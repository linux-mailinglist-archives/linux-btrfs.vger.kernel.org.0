Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09054159B49
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 22:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgBKVkr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 16:40:47 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:39373 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgBKVkr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 16:40:47 -0500
Received: by mail-qt1-f179.google.com with SMTP id c5so15625qtj.6
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2020 13:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAMSwIEzg0vMCmlmg9bS5b+g9N53VqyU1MlE+9wg5No=;
        b=mi4c5xV4Q3X5vvckb0vygOl0j12wjjGAk4WwfOlnuBjhXzERdzcHfUJoWoBEq6L+0p
         NpiISZmZlw504Up0spvX0qn99hducmVkUZm8FiuvTksHd8YIaJN6/M7Q4Pp1bSwYaonQ
         kYbBY0erZ2IFFoYfEvyGbBILxpFTOyNurlQtIgUaiSBxmjFnjEP2/LNZGJQz+SE5hQdd
         TnP+GbC3t9Dcb+jxC6Ov9Je2zhaObdatEfOdw4UnO62pPipNfTtc1BsrMZrQ8+CGQQcI
         Sk6ex6+/Q0enKCgtKmV7FpBrwUzDNbu8KxX7phmJ72HFcPuH2oPXnpu9Ea3cZbU6FaSM
         Ke3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAMSwIEzg0vMCmlmg9bS5b+g9N53VqyU1MlE+9wg5No=;
        b=SsbXMV1S+rW8e1ofslxpqQtZwQCwLw1/uFkDoR9JVOtsmZDqVYLAM40+pCoa0SXjve
         SnRcvdocqfylGlJ4XF9KVvpdhpMV2cru+l3CvebbH8DVKcBdmsuMjzoE3/7gTrVy11ZP
         o4MHtFHXI9Vpagg8jkIKp9EyP2dxjyKNXw6hPil/5TH8QOkqrvmdl0+lKjoXXmnLhlr9
         r9whLxG+gKrTDgkCH0JoiXquL40P1JVYJvnaRxvCejjGwwkgFIpmTtZ1NEdSImJ8ZRap
         /1iU4Eab141Gnrx4+Jb3uikC9C6+KRdK8P0LNImgLoG4N5X1gFKg681aAloCVGKvYsG6
         4wgQ==
X-Gm-Message-State: APjAAAXuUPwW/6fMTpCSD5vnXuLBUrq6Os3WwTvfzXoteSw/ClG84C4C
        ZgkZhITGrawtoi6KZCZ6zH3zcpTqLdU=
X-Google-Smtp-Source: APXvYqzOXkO03ugQmZ4dlDPuSi9lJFDjYMy2R1z8+zOGRnb9RhVjh0VFgtScMooBOTFRTpjNGoHVfw==
X-Received: by 2002:aed:25a4:: with SMTP id x33mr4472185qtc.165.1581457245637;
        Tue, 11 Feb 2020 13:40:45 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n123sm2676180qke.58.2020.02.11.13.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 13:40:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/4] Error condition failure fixes
Date:   Tue, 11 Feb 2020 16:40:38 -0500
Message-Id: <20200211214042.4645-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've been running my bpf error injection stress script and been fixing what has
fallen out.  I don't think I've fixed everything yet, but to reduce the noise
from Dave's testing here's the current set of fixes I have.  These are based on
misc-next from late last week, but should apply cleanly to the recent set.
These aren't super important, but will cut down on the noise from things like
generic/019 and generic/475.  Thanks,

Josef

