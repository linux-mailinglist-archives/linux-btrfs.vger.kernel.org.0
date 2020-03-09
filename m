Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7EF17E9E7
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 21:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgCIUX1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 16:23:27 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:39610 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgCIUX1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 16:23:27 -0400
Received: by mail-qk1-f172.google.com with SMTP id e16so10621063qkl.6
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 13:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Ju1Rk3ro5mG6G1lwjlpIrAZ8TJNf15wJjnAEpq61eI=;
        b=cMaK24tWhZK09/mjC06AQgyP4KYi1WPN/6h6Mzj7L+RnbbyDMQpKhSiasgG0pTApZU
         ouxpMo33PKWv/IySOroNWFwL5/ZUAYdlYm+lWS1uW9+1O6wjVSK0HGRftrwICC8cNQEs
         wMPWJ/FdUriq4EZpCaAV7Plq+m/Qe81Vl82fS84VCPi9eEXsw9Q/i9QUlUPjISa3rH02
         JnbLV8AWgRmXsv02GkaFyO5yFaIJxySSS6GzDzpGYa22gGqAIAn48xL8M4x/IgR7g9sR
         ulDx+W6oGnS4N3IEtbrQRJ4QF9IENXGFVPVKkSK48YJAt0JXyu4A4a3ftpH04eFWppqi
         e6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Ju1Rk3ro5mG6G1lwjlpIrAZ8TJNf15wJjnAEpq61eI=;
        b=DMWcD4FoHIRqdDwzDZhpiT20zlVe1qvirTVFIjkxDL92Q/iupXVPAH94GXKyyfX3OV
         wQxnRVLT10D3bUcoGBt6oEUq3q7b9cMCMStQ0ebCGFIh/L4vqF6rHvAShA4ysKCZB1u3
         V2qd5Q1BOi4OTfW2XdFnwvEfrB+XWyuh1XFWWAk8Vr0AhgnWeei7q3/Td4tSXwVPb0jL
         g+lBt2PLxI7e5LH2MmZ6NX+lwbm1DgmmwW2kNwkdEFzmZC3vuj/WkP0ulq4FqOEX2oGB
         MXV7Xc4g3lv31BLChT7tK0lBU8uRy1X+NGJMv2gH1/zoUpSfkpLCo1m7JwSjMKy4Hz/7
         WhOQ==
X-Gm-Message-State: ANhLgQ2UBUxIKkVJ9y187b2TAoCQyGRQEE59BfgqyuaKr2PoGFB9w1Rg
        EzBuEASH5bg2A7dtAJTHNIDoVRpz6Ac=
X-Google-Smtp-Source: ADFU+vt1W927IYpm/+XXjoQZWWkIYyp9PE0juV23lV9N5a02mJ931XfiFoVhu1Tq8SXC8KBLo/VgRw==
X-Received: by 2002:a05:620a:21d2:: with SMTP id h18mr6179666qka.270.1583785405741;
        Mon, 09 Mar 2020 13:23:25 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f13sm3197570qka.83.2020.03.09.13.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:23:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/5] Deal with a few ENOSPC corner cases
Date:   Mon,  9 Mar 2020 16:23:17 -0400
Message-Id: <20200309202322.12327-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nikolay has been digging into a failure of generic/320 on ppc64.  This has
shaken out a variety of issues, and he's done a good job at running all of the
weird corners down and then testing my ideas to get them all fixed.  This is the
series that has survived the longest, so we're declaring victory.

First there is the global reserve stealing logic.  The way unlink works is it
attempts to start a transaction with a normal reservation amount, and if this
fails with ENOSPC we fall back to stealing from the global reserve.  This is
problematic because of all the same reasons we had with previous iterations of
the ENOSPC handling, thundering herd.  We get a bunch of failures all at once,
everybody tries to allocate from the global reserve, some win and some lose, we
get an ENSOPC.

To fix this we need to integrate this logic into the normal ENOSPC
infrastructure.  The idea is simple, we add a new flushing state that indicates
we are allowed to steal from the global reserve.  We still go through all of the
normal flushing work, and at the moment we begin to fail all the tickets we try
to satisfy any tickets that are allowed to steal by stealing from the global
reserve.  If this works we start the flushing system over again just like we
would with a normal ticket satisfaction.  This serializes our global reserve
stealing, so we don't have the thundering herd problem

This isn't the only problem however.  Nikolay also noticed that we would
sometimes have huge amounts of space in the trans block rsv and we would ENOSPC
out.  This is because the may_commit_transaction() logic didn't take into
account the space that would be reclaimed by all of the outstanding trans
handles being required to stop in order to commit the transaction.

Another corner here was that priority tickets could race in and make
may_commit_transaction() think that it had no work left to do, and thus not
commit the transaction.

Those fixes all address the failures that Nikolay was seeing.  The last two
patches are just cleanups around how we handle priority tickets.  We shouldn't
even be serializing priority tickets behind normal tickets, only behind other
priority tickets.  And finally there would be a small window where priority
tickets would fail out if there were multiple priority tickets and one of them
failed.  This is addressed by the previous patch.

Nikolay has put these through many iterations of generic/320, and so far it
hasn't failed.  Thanks,

Josef

