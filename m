Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA774A4ACB
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jan 2022 16:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379781AbiAaPks (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jan 2022 10:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350284AbiAaPks (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jan 2022 10:40:48 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F52C061714
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jan 2022 07:40:47 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id h14so12705885plf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jan 2022 07:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=tXROVyb2fOBqkDYY3tI5YXet1knz5NECHKgqXDCwXzs=;
        b=Q1GDleCbtpmSW23eTOacDxd7lSoCOF5VaK/+q2M5K1DknvKA1WpWw3YIjwG9yyexW6
         xKJpjh9Wbam6BgzOoofD4SxVAu2jq+lkngcpxVGdDR+Q3H9sU59u9Z33o5NsarxEEbGJ
         LYEWJv3RcEjw4YeoyMkY8nDvm/TBeresOpBAIi6vZj64vxUwCATuRDlLOidc7h4vx2xM
         xvlN4rScveWcWnZZrPaKG+XYT26gU7ZOIEvs9g8l9GwyJHyBcbA98I3/fJuOkRhlCkUk
         R7ElB4lx0ekPvokqYaHpOu+yJEZS/Gmcq1pd4tkZbLZtESQWgMRP6+9n1qPkehKGcgvw
         Ig8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=tXROVyb2fOBqkDYY3tI5YXet1knz5NECHKgqXDCwXzs=;
        b=YoqpH5sod7Y+xMddNujsXytdSacCpk2VRBwX+lwMkAMLqB7DjZPN2YSHtCun0ewXB6
         73bc3zx18AH67usRYMyFHthbHxlzunYb9SAbrw+LJompSfRp0nYBkbFOYMwOu5RdriN1
         1E1/E5Ft0Q/ttMS4qPnuyqvekuFGRoJ+LV2E3IcHRX4yOu9JuCnILDdsmS0Mrrew+jUy
         m4odCADUBC+t6oBsPe6Fnlh3laYiXC8+wqiujGWmrUV5MO7iPaYwbseDOBHJm29ms7IG
         ovfSrJT6LeTDJDv6jMqphlkniSesCgCtkCxpGXp+lNCn63ihdC1u71/5S7Llz4bJw5wh
         LC4Q==
X-Gm-Message-State: AOAM531V9km5y7e9e9Ta866M8CR+50AORDfcWqdY9CCGA/95X4vUkBfm
        GBasJDryRNUPjtd9ANwOLwf8wEvt2ZyzXA==
X-Google-Smtp-Source: ABdhPJyIwPZf4iaBbAJECGdNHsKqJg9ckitTbSFv/x/s4vYg4R8vVw4vjyYRAwn1PBdEhRU0JN1uhQ==
X-Received: by 2002:a17:90b:4a47:: with SMTP id lb7mr35183499pjb.58.1643643647340;
        Mon, 31 Jan 2022 07:40:47 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id lb7sm12442506pjb.56.2022.01.31.07.40.46
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 07:40:47 -0800 (PST)
Date:   Mon, 31 Jan 2022 15:40:40 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: A question for kernel code in btrfs_run_qgroups()
Message-ID: <20220131154040.GA25010@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I'm reading btrfs code for contributing.
I have a question about code in btrfs_run_qgroups().

It seems that it updates dirty qgroups modified in transaction.
And it iterates dirty qgroups with locking and unlocking qgroup_lock for
protecting dirty_qgroups list. According to code, It locks before enter
the loop and pick a entry and unlock. At the end of loop, It locks again
for next loop. And after loop, it set some flags and unlock.

I wonder that it should be locked with setting STATUS_FLAG_ON? if not,
is there unnecessary locking in last loop?
