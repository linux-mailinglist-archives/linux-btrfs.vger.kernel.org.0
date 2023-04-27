Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49486F0CAD
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 21:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245140AbjD0Tow (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 15:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344017AbjD0Tou (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 15:44:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABFF270F
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 12:44:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-504fce3d7fbso13725602a12.2
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 12:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682624687; x=1685216687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIRE/NmaE8VFfuDsBE6zlrzj3JHd1mPg4yZEgvpxz10=;
        b=MeSMXQ98MBiNRFDWh6TR3ZiIQbbN0f03D8wWNOQ+86vjNc+Y6+efbJgwSkh3SBCMXw
         EfFc9YHrQRvrTODi6OgfURfWYlIGaCx0ZyraCT6GG/Jq6EsmtbeFiy7vtXnqz2zKQUHq
         cZUlKyTBbG4gQOYAGAOdGtrSaPTP2nPGm31IqRKgU1XXax/wxQisbzYtPBHqeOK6Oub0
         yXGIJjjriSffKdzN1UkwZhAiJ+Y9jZrQ8XBUDyGupO7ypBuBV1LI8TeU6Rao0DPJZ5Qp
         eyngnCs40ZsWTTkQo1ECnRDMMifEqiDcRVjk30L+rjbMQsH68fBrq+WAldjNeumI/Y5t
         HNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682624687; x=1685216687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIRE/NmaE8VFfuDsBE6zlrzj3JHd1mPg4yZEgvpxz10=;
        b=dL+rFwmCPXRf+79VLvOQ9PlRET726HngTbY6Ihlu8ILcaj/g2Sfo9JY4AHr498xyja
         uAmggqzF7/ArTwZbzsFRYETy0ynvIKhRGriOBi+bFk2DO+g2cIuPwVRWoeg2Zo5bfNpA
         tnAy9MybqMdTqPnuXrbKlCNLoMRvjf2/PY6k6n8xlZZojVONmpTnTT9HB2/5nSLYnCFT
         Pq8TZFvgiG0Uvj5NVRoBTM8+rJOddvD/oRfQPWFyDY2fc1tkbDuxaq81IiZHOu9V00TB
         mKhQ7gOzC1bHnIRUDYcxhmVSfAFh61DWm4snHOjJiXRJuZ3w53HgTVaKEAMHX/1ec4Ht
         DC8g==
X-Gm-Message-State: AC+VfDwD1ymqWDFp41GMt9+QQT/dVGHjxD/tFGjcsv4WARFRHU60rHLB
        0+9L0dbj4DTMw0f9LbD5+DCzAoK3YhLXcBDyyTlllJmBaOE=
X-Google-Smtp-Source: ACHHUZ6R8p0FpzdMbJVMAIxgXDz+w6BG8Llb2wtRV6z/+Ev0j54698r7c4A5ROD6khN1+E7qrp17ZSlKfinqr+yh3MM=
X-Received: by 2002:a05:6402:40f:b0:506:7695:ed16 with SMTP id
 q15-20020a056402040f00b005067695ed16mr2400257edv.40.1682624686701; Thu, 27
 Apr 2023 12:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230427131044.6804-1-dsterba@suse.com>
In-Reply-To: <20230427131044.6804-1-dsterba@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 27 Apr 2023 15:44:10 -0400
Message-ID: <CAEg-Je_KLtoX3HdfOtUdd3aHqSPYL+T5MFsjPAiqotcoVpUKXA@mail.gmail.com>
Subject: Re: Btrfs progs release 6.3
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
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

On Thu, Apr 27, 2023 at 9:26=E2=80=AFAM David Sterba <dsterba@suse.com> wro=
te:
>
> Hi,
>
> btrfs-progs version 6.3 have been released.
>
> There are some fixes and tweaks, the experimental status of block-group-t=
ree
> has been removed, namely the conversion but please still use it with care=
.
>
> Otherwise there's nothing interesting from users' POV, more documentation=
 is
> being moved from archived wiki, updated tests.
>
> The CI on github has been extended to cover devel and pre-release branche=
s,
> further enhancements are planned to do e.g. quick build tests for pull re=
quests
> or use self-hosted runners for heavier tests that may need to run against=
 a
> recent kernel. (https://github.com/kdave/btrfs-progs/actions)
>
> Release process now uses more of the github features, so besides the tag =
itself
> there's also a release with changelog (https://github.com/kdave/btrfs-pro=
gs/releases).
> This allows to add "artifacts" i.e. other files besides the sources.
>
> There are now static binaries published along with the release. They're b=
uilt
> inside the CI workflow "Static binaries" (also available there for downlo=
ad).
> The upload is still done from an intermediate host so if you don't trust =
github
> CI or me copying the files as-is, please build and use your own.
>
> Please let me know if you have suggestions for improvements or if you fin=
d
> problems with the CI/release things. It's new to me and I'm sure the are
> already best practices to follow.
>
> Changelog:
>    * mkfs: option -R deprecated, options unified in -O (-R still works)
>    * mkfs: fix potential race with udev leading to EBUSY due to repeatedl=
y
>      opened file descriptors
>    * block-group-tree is out of experimental mode
>       * available as 'mkfs.btrfs -O block-group-tree'
>       * btrfstune can do in-place conversion to/from (use with care)
>    * balance: fix recognizing old and new syntax
>    * subvol snapshot: specific error if a failure is caused by an active =
swapfile
>    * tree-stats: rephrase warning when run on a mounted filesystem
>    * completion: 'filesystem du' also completes files
>    * check: fix docs, help text and warning that --force + --repair works=
 on a
>      mounted filesystem
>    * build: fix static build when static libudev is available
>    * documentation:
>       * more updates from wiki, developer docs, changelogs
>       * reformatting
>       * updates and fixes
>    * other:
>       * test updates and fixes
>       * CI cleanups and old files removed
>       * integration with Github actions
>
> Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-prog=
s/
> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

It seems like my patch to default to 4k pages[1] was missed for this
release, despite having three reviewed-by tags.

Can we get this pulled in for the next release then? And I guess the
patch will need to be updated to say 6.4 instead of 6.3...

[1]: https://lore.kernel.org/linux-btrfs/20230322221714.2702819-2-neal@gomp=
a.dev/



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
