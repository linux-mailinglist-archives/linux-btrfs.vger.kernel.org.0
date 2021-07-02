Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2FB3BA2E5
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 17:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhGBPu1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 11:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhGBPu0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 11:50:26 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D99C061762
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jul 2021 08:47:53 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id w22so974592qtj.8
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Jul 2021 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=0B4zIAac+K9gEa9IG4XD4wmlLfM13eBPCZz8rpwnHHE=;
        b=sWfkrQ4p0qy5alDz2j9EUbLrlesQV41jQ4DU8ybrmU0ug0C1Q+ps+6NwOZHgFf2zcY
         DA9BIpQSni0hc+K6xQvXUqPv8RhD26AhepUKwH3+PWe94coI7Sad/SNQsN9byKXKw9pT
         ISznAU7DZhHRk7ybwHSdn3akBGQBkhvPtthpW4ftKMTq7/8XW0kBi08vJOlaYVAyJl07
         8x76xky/vdScRjqROV2Fdh6BrCfdNzMbRr0Tetq6G2yIFYC/7Wi1kKb0rRbZVe2Ehybl
         0vCzw4YGsaIqRn6l3cHxe+dy46XrT3O6BUBWRt6nKuaOAKuw5zNc+q9ifmkTxXMOj3Fa
         pXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=0B4zIAac+K9gEa9IG4XD4wmlLfM13eBPCZz8rpwnHHE=;
        b=B7322JNCTKuBocL7/C1DoKBksEBd6iCc/NTmpURIzA5r7s3YkvOnY2vkXvZiApBlVr
         TBMUSCFfEzQPL9X/Ie9hJHSm4e2jhhzDUloO+Bce6dStn7Qg0f312ZnE8OkkISH+6XEm
         B9/L6AdCDKX3baMe5NJZ83maJlXsArtb5pFbP6dT3jNbyUZgeAxzrlyIlHbYWJOq5pzR
         D861HztPX0gY+dRmSIY6cvmMXI4WBm9v8mKO4R0U9FzHi7UAQdfYjTwG6eR/9aVsfjwy
         OOdMXBceIZMdgYLJeKMBIacN8k3Wrb4bPc+8/NzeqkOcNPE6PlRuIN5bf7TPXLbAJsJu
         1mvg==
X-Gm-Message-State: AOAM533knG0dNxZmYNzG4AHDqOKySiYGQa6i8C0iRvWIDf0pT8rCnznY
        7E8K0OKA1p7w8op/EXrAnJh2d0KXKSVQW2M7ZcI=
X-Google-Smtp-Source: ABdhPJwMqN90IzOk23WrmLcYhK1xn/CboESLRNCnbvx6M4t9OxMbwZHHt6Fi9Tph7+ulM/qVGDBAHgYYNOfwjOEm8Ds=
X-Received: by 2002:a05:622a:1a23:: with SMTP id f35mr346935qtb.21.1625240872561;
 Fri, 02 Jul 2021 08:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210702124813.29764-1-nborisov@suse.com> <PH0PR04MB741661FC90F8B379EC1E5AEA9B1F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H5VFtoMkPi9aWErDcWeeWMdsY-2btzfEELrCiizk_mSZw@mail.gmail.com> <9d06d4cf-50ee-c7d9-d4cb-92b60bbe5874@suse.com>
In-Reply-To: <9d06d4cf-50ee-c7d9-d4cb-92b60bbe5874@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 2 Jul 2021 16:47:41 +0100
Message-ID: <CAL3q7H5morJO7qp7m8F81YAznor+q=NBBuzi4GEfMV8nyYfBEg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Make btrfs_finish_chunk_alloc private to block-group.c
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 2, 2021 at 4:03 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 2.07.21 =D0=B3. 17:12, Filipe Manana wrote:
> > On Fri, Jul 2, 2021 at 2:21 PM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> On 02/07/2021 14:48, Nikolay Borisov wrote:
> >>> One of the final things that must be done to add a new chunk is
> >>> allocating its device extents and inserting them in the extent tree.
> >>> This is currently done in btrfs_finish_chunk_alloc whose name isn't v=
ery
> >>> informative. What's more this functino is only used in block-group.c =
bu                      function ~^                                 but ~^
> >>
> >>> is defined as public. There isn't anything special about it that woul=
d
> >>> warrant it being defined in volumes.c.
> >>>
> >>> Just move btrfs_finish_chunk_alloc and alloc_chunk_dev_extent to
> >>> block-group.c, make the former static and it to alloc_chunk_dev_exten=
ts.
> >>                                    rename ~^
> >>
> >>
> >>> The new name is a lot more explicit about the purpose of the function=
.
> >
> > I find the new name confusing as well.
> >
> > alloc_chunk_dev_extents() suggests it's allocating device extents, but
> > it's not, all it does is insert the device extent items into the
> > devices btree.
> > Allocation of extents happened in phase 1, through btrfs_alloc_chunk().
>
> The reason I give it plural name is because the inner function is called
> alloc_dev_extent hence I gave the top level functino a plural form. I'm
> fine simply renaming both functions to insert_dev_extent[s] respectively?

Yes, that's much better. Either "insert" or "add".

Also please fix the changelog:

"One of the final things that must be done to add a new chunk is
allocating its device extents and inserting them in the extent tree."

The allocation part is not done in this phase, as I mentioned earlier,
and the insertion is in the devices btree and not in the extent btree.

Thanks.

>
> <snip>



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
