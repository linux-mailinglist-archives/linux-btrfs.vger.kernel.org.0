Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53084637FFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Nov 2022 20:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKXT71 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Nov 2022 14:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiKXT7Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Nov 2022 14:59:25 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC285FF9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Nov 2022 11:59:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z18so3750335edb.9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Nov 2022 11:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pK5BFeqPZlGsYcUWZ9wihrIlc2C5gA9K4Ybqt8H/RB0=;
        b=jqxotS1j0HDaAJGLc3pe+ujKh8yKJ4kYo9qKfhhryuED6z9sbFYGm2DXmDpRRf6Obw
         2pkqnUAR7CoirbdanwTI+cQdHetrUVkCpxzRxrkERJGAPFhT08FQ5ROXmXQRnnRXfasP
         vXdiSsUzqbmeCwG2vfEHQ/WhL/cwwPNUtgpkGEtLHpf0RXb/Bp166tsyY+i4TVuHidW5
         /SlgLR/asp6dxkrF4x/tX3D3/tSJhfW4XFq+ZMebsqlIVKvehLbBPTJj1nyj9ITQmHQQ
         FwtejpMTUg/yv1W+fED/TexToMfncO0AEUEsDwyvqMlvgHPJ/o9IFpcXWpPd2wYVJXS2
         gPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pK5BFeqPZlGsYcUWZ9wihrIlc2C5gA9K4Ybqt8H/RB0=;
        b=vbJf32dr1oCspisoYcHPjVjCmUqOf7R8AVLPQmW3bhJ/eHXC6aMLvbS48xc1uQcc9z
         88enre7fith1hTdnOPblWJCQ9boz9uD8VAvYOV2gGGtg6UpGZSXqjjePl0eB5bLhATwW
         Y9cIEqUhdZQ4R9DQdgGgY+PO4emk2iH91EdK+mG5M0gmsSjXiIArFNxmZXAWYZNhvamc
         8Y391rGpcLgjLOdn6GU9imGUeeSOJcvg+7PEga8JoOieJ6EDFvChqnfTh4rt9eZoAPzg
         fO3lFIWjlBUlqFzOVs81i2+te53xUoEz4ayy7vsP88RRrG21TFK5YRPT007KXfhyEZjj
         3X6A==
X-Gm-Message-State: ANoB5pnyqyVoGrMHiiDo19aXFg3Ni/2IH8peifUSGcjBSUUtDDIGIF0q
        tBIrpNKkmCkVHEXAUXRrjYyCbht5FxsiFIXzzHQ=
X-Google-Smtp-Source: AA0mqf5z9brOdkH+LUx+ZG7JH1aGaTpWs+MUA6dPFrtE1REEVMe0pTcd29Mp0xeFotHImKvEMLVtdONwrWN/RaC/DXk=
X-Received: by 2002:a05:6402:685:b0:46a:890d:b0d1 with SMTP id
 f5-20020a056402068500b0046a890db0d1mr3854760edy.292.1669319962369; Thu, 24
 Nov 2022 11:59:22 -0800 (PST)
MIME-Version: 1.0
From:   Torstein Eide <torsteine@gmail.com>
Date:   Thu, 24 Nov 2022 20:59:11 +0100
Message-ID: <CAL5DHTHvSvHN-2TvEu_UVnnYOmBe-gCywkTVv6+DVK5SDB2u6g@mail.gmail.com>
Subject: Re: [PATCH v1] btrfs-progs:Support send and receive to remote host
To:     quwenruo.btrfs@gmx.com
Cc:     clm@fb.com, dsterba@suse.com, hmsjwzb@zoho.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        strongbox8@zoho.com, sunzhipeng.scsmile@bytedance.com,
        gpiccoli@igalia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu

>>> A quick glance shows no special error handling or network specific behavior change, thus why we should bother something can already be done by the very basic pipe?
>>
>> This patch is just a proposal of send and receive through TCP connection. If this feature worth some effect, I will spend more time to optimize it.

>You're fighting a uphill battle, thus you'd better to explain your patch
>harder, from the use case to its advantage/disadvantage.

I do think there is a place for  a daemon option beside 'btrfs send/receive'.
A use case I think can be advantageous to have btrfs be as a service,
is for updating IOT devices, gaming devices, etc.
Where the developers can use btrfs to publish new versions.
I got inspired by Guilherme's use of BTRFS in SteamOS, using BTRFS as
readonly FS for system disk with A/B partitions/volumes.


## EXT4:
Using ext4, with separate partitions, for different versions.
`/etc/fstab`
````
/dev/sda1     /     ext4   ro   0      1 ## version A
## or
/dev/sda2     /     ext4   ro   0      1 ## version B
````

## BTRFS
Using BTRFS with subvolumes on a single partition/disk.
`/etc/fstab`
````
/dev/sda     /     btrfs   ro,subvol=2201   0      1 ## version 2201
## or
/dev/sda     /     btrfs   ro,subvol=2210   0      1 ## version 2210
## or
/dev/sda     /     btrfs   ro,subvol=2211   0      1 ## version 2211
````

I  believe BTRFS can be a tool to send updates, with the following advantages:
- Would keep the total size down.
- Minimize wear to the system disk.
- Allow for more OS-versions, within the same footprint as 2 full A/B versions.

I think the implementation can be similar to `rsync `demon.

## Get list of remote snapshots
````bash
btrfs remote list ${host}
````

## Get subvolum
 ````bash
btrfs remote pull ${host} ${base_version} ${new_version} ${destionation}
````
I believe it needs the following features to work good (on top of
'btrfs send/receive'):
- Encrypted
- Authenticated
- Possible to restart
- Liste remote snapshots
- Error handling
- Log
- Debug tools, verbose, progress, etc.

Then you can use scripts or grub to boot different versions.


-- 
Torstein Eide
Torsteine@gmail.com
