Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092BABBB25
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 20:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440442AbfIWST2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 14:19:28 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:34626 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440439AbfIWST2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 14:19:28 -0400
Received: by mail-ed1-f51.google.com with SMTP id p10so13851793edq.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=7r4F5OxsnmfDikyieFq2a5mGhu6YpOafXGIh6VAAyBs=;
        b=J9FhPVPXC26QyI9LEq5RuI7yXWlXFa6i88ClBLiaX4yXR8CyjSi0Dq9aZKSgzv+tch
         +HBUn6yoOmGtEGKETMhaCBb+UccRsyyVG/VeZGPQV/vUqjauWfuXPHiFg29EVrFEFwN6
         xg/IlZaHAnHJ0LPUQlhTl1TTUJ+N4+bQ9NLDRza5nze68RP/W5jaNOwkyPLFvJFBQOVy
         dVfP8fzzSZSCK8/lXEDkjI0rganMJWTRXWKqcOa1szXY3d9xUTg/C7ELe3G3oPpX7kY4
         TTN2FYyt01z/+d0QwTnaw7x+LFh6V2o/S0UrnKe4bbuh28KhfOTRhxbhnJoZMIWtL1NO
         Brgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=7r4F5OxsnmfDikyieFq2a5mGhu6YpOafXGIh6VAAyBs=;
        b=fZQD+VzSynB/Jl4iO330U//UKv38djVRMPaDJzkTgImGGRGrm6zDU2GSNtMjXATKWR
         h0t74gMWBPZ0omSD5B3BAsUFsB2uO6axZ/6Vu2ga3XuuJE35uUwSbBw/kpoo9MgqT78J
         hfVwTTjK3LgVcqiZQVchcmlSLh8Meb2W0pgfU3EnfKrFBaUTbFhsZzcawuviVGAFoC/I
         i4urmb8g4dX+W1Q3NjdS/xZnIv1dgcaWfStS/pCMn8pi+sispNKnDSQLiOJbZg0VEYXP
         iQJ6gTpQ1HwDdtsZvcsA8kCxcxrZkB1XiKfpgx58A6rb89u6AhNncv0xQ3T3MD0Jsq8I
         bKWA==
X-Gm-Message-State: APjAAAUdGsg4NOqEsu0GxVsXhVK5hJUaeifU2lmR7p/nLrFdn0Ew8M9v
        O3ddoQWE3a7VIDvVNc5PcMom6UO+rD8=
X-Google-Smtp-Source: APXvYqwdujIjhVYyonhC+XvEEJ1yG4Ooa/BOg0nv2MU/qyAfGpTD9W7HiviEk9TVH0vEhceedleOew==
X-Received: by 2002:a50:a7c4:: with SMTP id i62mr1516937edc.92.1569262766250;
        Mon, 23 Sep 2019 11:19:26 -0700 (PDT)
Received: from MHPlaptop (xd520f268.cust.hiper.dk. [213.32.242.104])
        by smtp.gmail.com with ESMTPSA id v4sm2525528edy.54.2019.09.23.11.19.25
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:19:25 -0700 (PDT)
From:   <hoegge@gmail.com>
To:     <linux-btrfs@vger.kernel.org>
Subject: BTRFS checksum mismatch - false positives
Date:   Mon, 23 Sep 2019 20:19:24 +0200
Message-ID: <000f01d5723b$6e3d0f70$4ab72e50$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdVyO22XlGIcXaePSIiSisyS1vf28A==
Content-Language: en-us
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear BTRFS mailing list,

I'm running BTRFS on my Synology Diskstation and they have referred me to
the BTRFS developers.

For a while I have had quite a few (tens - not hundreds) checksum mismatch
errors on my device (around 6 TB data). It runs BTRFS on SHR (Synology
Hybrid Raid). Most of these checksum mismatches, though, do not seem "real".
Most of the files are identical to the original files (checked by binary
comparison and by recalculated MD5 hashes). 

What can explain that problem? I thought BTRFS only reported checksum
mismatch errors, when it cannot self-heal the files?

Best
Hoegge



