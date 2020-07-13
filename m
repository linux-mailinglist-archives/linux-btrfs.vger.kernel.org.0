Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0193E21E0F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 21:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgGMTqj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 15:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGMTqj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 15:46:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CDCC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 12:46:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f18so996905wml.3
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 12:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jOmu568DV3iG/AmMbO3DvgHJhR/XcjURrvUnadhB8EI=;
        b=mJ5cZcdxnNKzG/EHwV6iiT/isruajnhBxkxBstwdcA+Xjuf7EDsoNDJ8cJp1ZEargX
         uGTDPWhqiO5HfgBPlPVmhjiDUwYb6GEuS2YB5nDmtRgvfjgSrISHoepI2sYwSKZs8lLQ
         TcGWf6yXhIj3rCuliVvAraFBaHFnytxa1O59Fgcj1k8YTffKzhgIAZfZ4GyXOPtH/MgA
         slP+GDjEz74I3FRVz6wCuezgAAskxp2fbeVTVXY95V8y+QskvXWwnypg4lj+4vQecASj
         zgJAi/EpQ0oa7njrRGsEPxQHWwo8AuBgE/uCPBpWx54rmvlSNjBaRJtLypM/Jdjog3EI
         28FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jOmu568DV3iG/AmMbO3DvgHJhR/XcjURrvUnadhB8EI=;
        b=iQJEemK3odN3M/MXoevjpQ5nFgpYdUeChjJrSME+tslJO6YxQ387YtmzICqX1miVlH
         3BbSEgyhcjf1Idrvut4djue0bfkMfdz3swj5aJADzPP9l39MjtwMdF+kQGd/JllpGLOY
         u8t1RrLYaDQYsq9wRtuzC/yuCyf3+eNsGhuq2vovUD93J71E9VUVG2/bejId6CFFq4Dc
         K6LaH712HQP8rQUg7bWZfYjpH7cRAArpsd5S08Ap4bksd5IgEWZDMg4gmZ7uryc/ih/9
         IgpgNziHXOB+7d8C15DAKmHhe34EzfHP6qsKzo97fB0RhoE0tku8Z4wjf5L6mtvW6usm
         ccAA==
X-Gm-Message-State: AOAM531QWcts4NMZBXqCRC60N9pzPdC2kOa5K3OJwBRSBwVnRiRf+Yh0
        KjDdZKjUh6QNCHLsqZIu4ksWWTum
X-Google-Smtp-Source: ABdhPJzf94kLjoUHb9ngc0XxXNgd4utrdGwBI7SartazSqsLG0cQN9eAoQ6Jj0SbQNDAp76+DlNAXw==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr989409wma.18.1594669597605;
        Mon, 13 Jul 2020 12:46:37 -0700 (PDT)
Received: from [192.168.1.145] ([213.147.166.105])
        by smtp.googlemail.com with ESMTPSA id u17sm24392443wrp.70.2020.07.13.12.46.36
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 12:46:37 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Christian Zangl <coralllama@gmail.com>
Subject: "missing data block" when converting ext4 to btrfs
Message-ID: <90fff9c0-36c5-d45c-d19b-01294fc93b1e@gmail.com>
Date:   Mon, 13 Jul 2020 21:46:35 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I am on a test VM where I am trying to convert a second disk to btrfs.

The conversion fails with the error missing data block for bytenr 
1048576 (see below).

I couldn't find any information about the error. What can I do to fix this?

$ fsck -f /dev/sdb1
fsck from util-linux 2.35.2
e2fsck 1.45.6 (20-Mar-2020)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/sdb1: 150510/4194304 files (0.5% non-contiguous), 2726652/16777216 
blocks

$ btrfs-convert /dev/sdb1
create btrfs filesystem:
         blocksize: 4096
         nodesize:  16384
         features:  extref, skinny-metadata (default)
         checksum:  crc32c
creating ext2 image file
ERROR: missing data block for bytenr 1048576
ERROR: failed to create ext2_saved/image: -2
WARNING: an error occurred during conversion, filesystem is partially 
created but not finalized and not mountable

$ uname -a
Linux t-arch 5.7.7-arch1-1 #1 SMP PREEMPT Wed, 01 Jul 2020 14:53:16 
+0000 x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v5.7
