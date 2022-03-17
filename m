Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495934DBE97
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 06:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiCQFqT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 01:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiCQFqR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 01:46:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7151229B7ED
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 22:16:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b28so7183545lfc.4
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 22:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=gAHaGTTqBLzkDDScGSNIeMZ3A5NO37B995y2XQl4VX0=;
        b=CVF7DuPUB+qUhBNl6I5w0E3MfLkvpJUrfdcIglmOjT/d3btypYzV1OJFwZodJOhiBv
         2fCJmtbZBtOxwx95mYdqqbLXsbAp96qKSfr5MZceaWKo2GsrSJGlQfRliMy/XdJ3ca+k
         NzXZap3i/57jnFgP1Rva0KrWjTCMmiR2TLszf04p50Tg/vyfEr+Kd1wmpTyPN45TL4sE
         HECmYV0VoB6n+QOquV7RrkThc5naMCydyxXYkdKJige7XFUr++t8vmSrMmTMsgSiOkQk
         3mmBBONImTeAdjSCTNf9iNL3xfRrcw6u34csn5N3cGLVKhnsBLk3ycxutJgVhiLvdIn7
         FM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=gAHaGTTqBLzkDDScGSNIeMZ3A5NO37B995y2XQl4VX0=;
        b=IrUsAZ5K7GvNTJ3iwO/ycSv4pNyhgclRlyjTUcyPllJkLPjMapJxV6nZF1MbxIjSvD
         QsUChlQ3qk6aMC1jbuaEC3X71s+7K7Ojy0RgfVO5epLm9fV2/IEGSdhqj2L/OkV6AK+w
         VbGY765RRZLKud6KkAVwSHRVFjsuaGiqK+agpd+viHGMaUmPbE/mVjzti4IgPtsXMjw5
         X96DkE176O6DewicmzO0aEGFKDpAV04uUF/RLGHfP03EL+uxFtnFAxtfUY8hhLPqcWOO
         qtv7qQA1r5aRvlyq3MQzWgfAfMVfEZjCi1Cdms0V7tf29FvohQzCLDnocyLMN5W0BGrA
         ui/w==
X-Gm-Message-State: AOAM530j9xo9ssT6ChRel6syok+rVonMdKS3ZHEXVJBS/0YVr9Fk6Av6
        QVyy4mrFyKbsBZOtPcHibF52POfRHpHIU4FN67Pt1A==
X-Google-Smtp-Source: ABdhPJxV7QOe9eIWW954oOMJWlgdJN/oC2vpa7dHdG5spo/graE50pMaVcBurufA1xMAYboqfbxo9Q==
X-Received: by 2002:ac2:4d44:0:b0:448:b54b:c98e with SMTP id 4-20020ac24d44000000b00448b54bc98emr1742619lfp.302.1647494172441;
        Wed, 16 Mar 2022 22:16:12 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:3ffd:fa46:42b2:52e1:1c7d? ([2a00:1370:8182:3ffd:fa46:42b2:52e1:1c7d])
        by smtp.gmail.com with ESMTPSA id x10-20020a19f60a000000b0044858b2ec41sm337855lfe.187.2022.03.16.22.16.11
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 22:16:12 -0700 (PDT)
Message-ID: <cdc860ac-3d58-389d-fadd-acb47cc2e076@gmail.com>
Date:   Thu, 17 Mar 2022 08:16:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Subject: Misleading "out of memory" in btrfs check for qgroups
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

root@ubuntu:~# btrfs check /dev/nvme0n1p5
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p5
UUID: 6afe1f98-2fc5-4dd7-a22f-0b9e2f514a71
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups
ERROR: out of memory
ERROR: Loading qgroups from disk: -2
ERROR: failed to check quota groups
found 65546706944 bytes used, error(s) found
total csum bytes: 59958768
total tree bytes: 1668497408
total fs tree bytes: 1538752512
total extent tree bytes: 53886976
btree space waste bytes: 264382931
file data blocks allocated: 321153744896
 referenced 97287462912
extent buffer leak: start 300026445824 len 16384
extent buffer leak: start 300063735808 len 16384

-2 == ENOENT, but load_quota_info() prints "out of memory" for any
error. This leads to rather misguided attempt to "fix" it.

This was reported in

https://forums.opensuse.org/showthread.php/567851-btrfs-fails-to-load-qgroups-from-disk-with-error-2-(out-of-memory)

