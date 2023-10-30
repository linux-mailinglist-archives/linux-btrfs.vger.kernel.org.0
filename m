Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096B17DB8F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 12:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjJ3LbI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 07:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjJ3LbH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 07:31:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819B8C1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 04:31:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287E8C433C8;
        Mon, 30 Oct 2023 11:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698665462;
        bh=KYR/g0PzDrXFW2TppOR89K4gNk7qHMMTMss8zDepMOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F8kNftBYWgi62aGw91ofR6PzT79fWuUeHJMUTMWF4pLNp5T4YCl5Odpb18vOOX3+b
         N4tlmkX7Lntd9U/pOG/wU8I5E9PEDqz7Sa6wF+fEVrePiVPlpIPYArQ3WaqXYx38+I
         ABEkKdDMvft1y3YTbRZi/m56VX8oRqmqHVPtvDr5Pf//MqerQ+EQTXLDgDCv0vt3S7
         ZQH62YHtY4QM0xMA2QvT2voYcMAeecZMcC3vkVaJQeqgMv+2F97gJPtBS6yfezk5TX
         fdA9IobYJShjSzn94H5P5ysYaQYxGY0GE1TGJLiFPZNJJDi9+xnCSicA2TWuJlTFey
         0IbPETXuw9kNA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9d10f94f70bso337083166b.3;
        Mon, 30 Oct 2023 04:31:02 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx2WfNX3NO0CMmWzlnp7KDs6TbwrwM21poPzAMor8avucgv1N02
        ANGPMoNX0kjtV2vS1HDWqERxj5Yy9aQw54muW6c=
X-Google-Smtp-Source: AGHT+IHW+2U7Z598pMFliBVqQZIhbbH4KV6npbiFmo8RtyP2KwTijXo1V2HKa1tjaFUIxxI0hX5OuRRqctB0jQ7apeg=
X-Received: by 2002:a17:907:930a:b0:9ba:3af4:333e with SMTP id
 bu10-20020a170907930a00b009ba3af4333emr7649251ejc.14.1698665460580; Mon, 30
 Oct 2023 04:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698418886.git.anand.jain@oracle.com> <cf97bf909b5a67464f5dcf2a802b7d80c79c472e.1698418886.git.anand.jain@oracle.com>
 <CAL3q7H5d7MHHJFKkkcpg0Nt7naDbURVTpfzXDa8yMTVjxFy=hg@mail.gmail.com> <4b206721-5bbf-4ed0-9604-fd1adb0f2729@oracle.com>
In-Reply-To: <4b206721-5bbf-4ed0-9604-fd1adb0f2729@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 30 Oct 2023 11:30:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5SPo2k1kqLgpPpRUuXCvr-7W5YcKEzHQ7WmBjJAn-kpA@mail.gmail.com>
Message-ID: <CAL3q7H5SPo2k1kqLgpPpRUuXCvr-7W5YcKEzHQ7WmBjJAn-kpA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] fstests: btrfs/219 cloned-device mount capability update
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 30, 2023 at 3:29=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
>
>
>
> >> +
> >> +       # The variables are set before the test case can fail.
> >
> > What if the _require_* statements fail?
> > Then the variables won't be defined...
>
> Oh, yes indeed. It was fixed in v3 by moving the variable definition
> before the 'require' statement.

Is it really worth doing this type of change?
I mean it doesn't change the correctness of the test, doesn't make it
more readable or
maintainable, or even shorter... It seems pointless to me, no clear
benefit of any sort.

>
>
> >> +       $UMOUNT_PROG ${loop_mnt1} &> /dev/null
> >> +       $UMOUNT_PROG ${loop_mnt2} &> /dev/null
> >> +
> >> +       _destroy_loop_device $loop_dev1 &> /dev/null
> >> +       _destroy_loop_device $loop_dev2 &> /dev/null
> >> +
> >> +       rm -rf $fs_img1 &> /dev/null
> >> +       rm -rf $fs_img2 &> /dev/null
> >> +
> >> +       rm -rf $loop_mnt1 &> /dev/null
> >> +       rm -rf $loop_mnt2 &> /dev/null
> >
> > Also please for simplicity and clarity don't mix this type of change
> > with the actual purpose of the patch,
> > to make the test succeed on a kernel with the temp-fsid feature.
> >
> > You're mixing 3 different changes in the same patch...
>
> >> -loop_mnt=3D$TEST_DIR/$seq.mnt
> >> -loop_mnt1=3D$TEST_DIR/$seq.mnt1
> >> -fs_img1=3D$TEST_DIR/$seq.img1
> >> -fs_img2=3D$TEST_DIR/$seq.img2
> >> +loop_mnt1=3D$TEST_DIR/$seq/mnt1
> >> +loop_mnt2=3D$TEST_DIR/$seq/mnt2
> >> +fs_img1=3D$TEST_DIR/$seq/img1
> >> +fs_img2=3D$TEST_DIR/$seq/img2
> >
> > So this is the other unrelated change, renaming all these variables...
> > This is making the diff larger to follow as this has nothing to do
> > with the goal of making the test succeed on a kernel with the
> > temp-fsid feature.
>
>
> Sure. I'll move these changes to a new patch in v3.
>
>
> >> +_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1
> >> +
> >> +if [ $? =3D=3D 0 ]; then
> >> +       # On temp-fsid supported kernels, mounting cloned device will =
be successfull.
> >> +       if _has_fs_sysfs_attr $loop_dev2 temp_fsid; then
> >> +               temp_fsid=3D$(_get_fs_sysfs_attr ${loop_dev2} temp_fsi=
d)
> >> +               if [ $temp_fsid =3D=3D 0 ]; then
> >> +                       _fail "Cloned devices mounted without temp_fsi=
d"
> >> +               fi
> >
>
> Hmm. It is exactly testing what happens with and without the temp-fsid
> feature.
>
> > This is too complex. Why not just surround the existing code in an if
> > statement like this:
> >
> > if "sysfs-file-for-temp-fsid  does not exist" then
> >       run this code that fails with a temp-fsid enabled kernel
> > fi
> >
>
> Your suggestion will test what to expect when there is no 'temp-fsid.'
>
> However, if 'temp-fsid' is present, we expect its sysfs temp_fsid
> to be set to 1, which I believe is a straightforward verification.
>
> And do you think adding more comments will make it simpler?
> Such as:
> # If the second mount is successful, then check if 'temp-fsid'
> # is in the kernel. If it's present, verify that it outputs 1.
>
> Or, Are you suggesting we postpone confirming the correct operation of
> 'temp-fsid' for another test case? However, I believe in thoroughly
> verifying it wherever it's used, as this approach promotes a better
> understanding of what to anticipate. No?

I'm not suggesting a new test case.

Remember the code you removed in v1?
My suggestion was to instead of removing it, just surround it in the body o=
f an
if statement:

if temp-fsid-feature-not-abailable; then
   run that code you tried to remove in v1
fi

Isn't that a lot simpler and clear?

Thanks.

>
> I will await your response before sending v3. Thx.
>
> Thanks, Anand
>
