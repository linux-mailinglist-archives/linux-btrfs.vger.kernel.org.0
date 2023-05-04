Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97976F625B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 02:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEDAZI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 20:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEDAZH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 20:25:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CFB7AB2
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 17:25:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-24df4ef05d4so4198074a91.2
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 17:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683159905; x=1685751905;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7RxEV4ReqHv3qzLrTepF7YPC9hpar/j2mNoJG2lf9s=;
        b=B3KIzPbNgEkBJ4AI9E/h339rwRjXq2tXqmXrqwpuNkTYiR85o2kvQkSqS1yr4j0qqm
         nbGEvom1ZlWUrYfU9s8HLlik/+sAnzqyhj5t+aoodE9esC74bqKTauedJOvEd5c0nIrE
         7QlxlTUVdQjHcw1jJwLLMYt/Q8ufDEwaleOiWpbPiafYCmT76G6AM2ANVnlx1Q2hrEel
         ORlsUg9nXSBug19Gac6cBptUxQt+Fj6MteYvC03OP7/G0TCoVBiCQXyBZAcejUxyDBhC
         FzCYPwENSNwk4a9GmWLmSt3jbw7yGxhIh1TNfFOABzvtuDufljQTdnUG2jnW4J3bUDyL
         VlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683159905; x=1685751905;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7RxEV4ReqHv3qzLrTepF7YPC9hpar/j2mNoJG2lf9s=;
        b=bxWbqVcjPXzuDeddLrC+tmVdSLds2gpJsQwfkbHbUlBF2dlfc8hhaZOSwaQzzvAFx4
         AoBWkE51qjNNtnyCfOUsff4HA6fXqU5XUOQByfqJTrYwFTxbPIYQ+1ii/3yXTbg7KAui
         2/aHFva+Rnd/uXxIr4d4htlhG7jyAvNjAPeTfjEuKjIQigkDeyVndPFnZ4JNvNrFeemQ
         2qp8qdhrr+a8mFQ/ZBErvNeBd3BxzS9VyWFyMGqJtU3zk9qPs+UUX8Z/UIy7v/Iev69K
         yQMe3HDSonX3yfmkTjKzVQ6Ft4PU/8JxrmjrQD8IR3d4d/n40nH3yUz1rsJvzNLbd7Br
         lgcg==
X-Gm-Message-State: AC+VfDzNwDAnHotXiMKu2o5uCHDwjaaUvN/UCPWW9bu6eJbne2lq+F0X
        XCXqPH7j+QSAYDpO0uonl7TknX2oOQPohBN5dmhTOHyb+fI=
X-Google-Smtp-Source: ACHHUZ6YRzH+5zn+nwNILSz3OxmlAfZYKnfWVXr3XsNb9PPo7ClM08n4LlP60Ybm3WMDIoSVtKEFcs8VEj7IteiBh8c=
X-Received: by 2002:a17:90a:fd91:b0:24e:12ac:932c with SMTP id
 cx17-20020a17090afd9100b0024e12ac932cmr461355pjb.6.1683159905018; Wed, 03 May
 2023 17:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XNQ=ixcfB1_CXHf5azsB4gX87vvdmei+fxv5dj4K_4=H1=ag@mail.gmail.com>
In-Reply-To: <CA+XNQ=ixcfB1_CXHf5azsB4gX87vvdmei+fxv5dj4K_4=H1=ag@mail.gmail.com>
From:   Gowtham <trgowtham123@gmail.com>
Date:   Thu, 4 May 2023 05:54:53 +0530
Message-ID: <CA+XNQ=i6Oq=nRStZ3P1gCB+NtCrR0u+E_gW1CraLFyz0OoeJrg@mail.gmail.com>
Subject: Re: Filesystem inconsistency on power cycle
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi All,

Can anyone suggest a fix or a workaround for the issue in 5.4 kernel?

Regards,
Gowtham

On Sun, Apr 30, 2023 at 3:50=E2=80=AFPM Gowtham <trgowtham123@gmail.com> wr=
ote:
>
> Hi
>
> We have been running our application on BTRFS rootfs for quite a few
> Linux kernel versions (from 4.x to 5.x) and occasionally do a power
> cycle for firmware upgrade. Are there any known issues with BTRFS on
> Ubuntu 20.04 running kernel 5.4.0-137?
>
> On power cycles/outages, we have not seen the BTRFS being corrupted
> earlier on 4.15 kernel. But we are seeing this consistently on a 5.4
> kernel(with BTRFS RAID1 configuration). Are there any known issues on
> Ubuntu 20.04? We see some config files like /etc/shadow and other
> application config becoming zero size after the power-cycle. Also, the
> btrfs check reports errors like below
>
> # btrfs check /dev/sda3
> Checking filesystem on /dev/sda3
> UUID: 38c4b032-de12-4dcd-bf66-05e1d03143a8
> checking extents
> checking free space cache
> checking fs roots
> root 297 inode 28796828 errors 200, dir isize wrong
> root 297 inode 28796829 errors 200, dir isize wrong
> root 297 inode 28800233 errors 1, no inode item
>    unresolved ref dir 28796828 index 506 namelen 14 name
> ip6tables.conf filetype 1 errors 5, no dir item, no inode ref
> root 297 inode 28800269 errors 1, no inode item
>    unresolved ref dir 28796829 index 452 namelen 30 name
> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
> inode ref
> root 297 inode 28800270 errors 1, no inode item
>    unresolved ref dir 28796829 index 454 namelen 30 name
> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
> inode ref
> root 297 inode 28800271 errors 1, no inode item
>    unresolved ref dir 28796829 index 456 namelen 30 name
> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
> inode ref
> root 297 inode 28800272 errors 1, no inode item
>    unresolved ref dir 28796829 index 458 namelen 30 name
> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
> inode ref
> root 297 inode 28800273 errors 1, no inode item
>    unresolved ref dir 28796829 index 460 namelen 30 name
> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
> inode ref
> root 297 inode 28800274 errors 1, no inode item
>    unresolved ref dir 28796829 index 462 namelen 30 name
> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
> inode ref
> root 297 inode 28800275 errors 1, no inode item
>    unresolved ref dir 28796829 index 464 namelen 30 name
> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
> inode ref
> found 13651775501 bytes used err is 1
> total csum bytes: 12890096
> total tree bytes: 267644928
> total fs tree bytes: 202223616
> total extent tree bytes: 45633536
> btree space waste bytes: 59752814
> file data blocks allocated: 16155500544
> referenced 16745402368
>
>
> We run the rootfs on BTRFS and mount it using below options
>
> # mount -t btrfs
> /dev/sda3 on / type btrfs
> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subvoli=
d=3D292,subvol=3D/@/netvisor-5)
> /dev/sda3 on /.rootbe type btrfs
> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subvoli=
d=3D256,subvol=3D/@)
> /dev/sda3 on /home type btrfs
> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subvoli=
d=3D257,subvol=3D/@home)
> /dev/sda3 on /var/nvOS/log type btrfs
> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subvoli=
d=3D258,subvol=3D/@var_nvOS_log)
> /dev/sda3 on /sftp/nvOS type btrfs
> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subvoli=
d=3D292,subvol=3D/@/netvisor-5)
>
> # btrfs fi df /.rootbe
> System, RAID1: total=3D32.00MiB, used=3D12.00KiB
> Data+Metadata, RAID1: total=3D36.00GiB, used=3D34.19GiB
> GlobalReserve, single: total=3D132.65MiB, used=3D0.00B
>
> # btrfs --version
> btrfs-progs v5.4.1
>
> Regards,
> Gowtham
