Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094604858D5
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 20:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbiAETF5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 14:05:57 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:59079 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243276AbiAETF4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 14:05:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 28143320208F;
        Wed,  5 Jan 2022 14:05:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 05 Jan 2022 14:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=DiOnjRvfxp53fTT6KQ/z8DOAH/9
        O9YP9nls8tN8B4Vw=; b=RNC6Gpfx1PgntmHKkZ1nA9kmIQb0v/DQXsoYd/HrAu/
        il/IgVoNF654RbYlkCfGkdfnhgYGPNlMx2BRVqGG+QktA571pWJ655HAWOVZSVb9
        DlscTTmZKhINiUhiwZPjzlKKz75R3oK4FskBebaUfSGCeOfEZzxrQBQDTVI9MTOX
        4HRmp196JapX/hvCQvwFLlKb05heoLtfBS1gYys/zarMuiAKqeZiXuggbxfSX9V7
        8SUca4uHQwy/edP7HTbIQ7wkh1BkE8SerfoXAwX0M22+PGQljYglvaVcby2Ta70R
        +vplHvFk8ljjdM10lyIUUSW6P0bxZspBRoU8hvHH5Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DiOnjR
        vfxp53fTT6KQ/z8DOAH/9O9YP9nls8tN8B4Vw=; b=FsjAqaoKA+q31Om9YuBnHW
        tMpLQuNYJ3o3R/uHIAR9KRRyZrZ28r8TY92yoGzeaWNKRRAHQQwJqzHIUeDLv4uJ
        OmLXIurpGPkhy4w8VXchI8atAPEjIdS84X74Bts6ZxfChTYD81CSG/jmyuo9m6vS
        wLvextr8g6KO1bO7LbCoY3zDImmQLMu4eSs7k4X9IDNYdi08bK60N45uaBX+ghyD
        JSJUv1OAjv3HW7PLP7mGTbVgunNIkFJsZELCGc4vdcAviQm0+o1eeQHhXwinF9lh
        TGRc9QJd9dA8Jn42TZmmBx2Xl7r0tiK8KwFFU7EJwSG2b/v/fvNH3rjdSVAHAGrw
        ==
X-ME-Sender: <xms:EezVYWJZR3R5hAsoIZqUQqvbcdCeB4M6btx0KNGsKwruuYZIbZDnzw>
    <xme:EezVYeI2_UbhTpcOCW9yVxtLid2rUy9AiCJ6DX1eyY14WehmO3MaQUeKxWKiJ_VGU
    REpP6y3pJTMIxKKgz4>
X-ME-Received: <xmr:EezVYWvC10THbLl7YXxCZCBaOD3upkipHtGwmHlSE_o3USAOgQl1MNXOaA0kMR16pR_GeG8g7e5GcVQyjdysoNOeybWCDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeehudevleekieetleevieeuhfduhedtiefgheekfe
    efgeelvdeuveeggfduueevfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:EezVYbZVEXKLiy7-S7kuhEjDhluPC6ghMpCRzJROZ6LSiqYej8de3g>
    <xmx:EezVYdbGbjhL4sx-i4DAjD_yJJrSP93vmIihOoal5iH_sSqwiJ333g>
    <xmx:EezVYXCJ_e-bkS0gUZ7CveCk_5B1I2yGRnUXHJnVBJQql550n0ldcA>
    <xmx:EuzVYeChVJjDwmqG8x9Ov6pzNQbyXyzkRCDvnU1DgdrjziXXSzVImQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 14:05:53 -0500 (EST)
Date:   Wed, 5 Jan 2022 11:05:51 -0800
From:   Boris Burkov <boris@bur.io>
To:     kreijack@inwind.it
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] btrfs-progs: Allow autodetect_object_types() to
 handle the link.
Message-ID: <YdXsD+oQ8Z3DNYtG@zen>
References: <f4345fcac83ba226efdadcd4610861e434f8a73e.1641389199.git.kreijack@inwind.it>
 <YdXaZP27ALM6KJ9G@zen>
 <d4132584-faef-713e-aa7f-542257de3cfd@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4132584-faef-713e-aa7f-542257de3cfd@libero.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 05, 2022 at 07:23:33PM +0100, Goffredo Baroncelli wrote:
> On 05/01/2022 18.50, Boris Burkov wrote:
> > On Wed, Jan 05, 2022 at 02:32:58PM +0100, Goffredo Baroncelli wrote:
> > > From: Goffredo Baroncelli <kreijack@inwind.it>
> [...]
> > 
> > I took a look at the original lstat and it doesn't seem super strongly
> > motivated. It is used to detect a subvolume object (ino==256) so I don't
> > see why we would hate to have property get/set work on a symlink to a
> > subvol.
> 
> It is not so simple: think about a case where the symlink points to a
> subvolume of *another* filesystem.
> 
> Now, "btrfs prop get" returns the property (e.g. the label) of the *underlining*
> filesystem. If we change statl to stat, it still return the property of the
> underlining filesystem, thinking that it is a subvolume (of a foreign filesystem).
> 
> If fact I added an exception of that rule, because if we pass a block device, we
> don't consider the underling filesystem, but the filesystem contained in the block
> device. But there is a precedence in get/set label.
> 
> Anyway, symlink created some confusion, and I bet that in btrfs there are areas
> with incoherence around symlink between the pointed object and the underling
> filesystem.

Good point. I agree that btrfs (the tool) is not the most rigorous with
symlinks. In this very function, we check if it is a btrfs object by
opening the file without O_NOFOLLOW, but then we do this lstat.

I'm not exactly sure what you are alluding to regarding the precedent set
by label, but I tested links and labels and it seems to exhibit the link
following behavior.

mkfs.btrfs -f /dev/loop0
mkfs.btrfs -f -L LOOP /dev/loop1
mount /dev/loop0 /mnt/0
mount /dev/loop1 /mnt/1
ln -s /mnt/1 /mnt/0/lnk
btrfs property get /mnt/0 label
label=
btrfs property get /mnt/1 label
label=LOOP
btrfs property get /mnt/0/lnk label
label=LOOP
btrfs property get /mnt/0/lnk ro
ERROR: object is not compatible with property: ro

So it looks like root detection follows links but subvol detection does
not. Without testing, but judging by the code, I think inode follows
symlinks too. So with all that said, I think the most consistent is to
make subvol follow the symlink, unless you have a really confusing
unexpected behavior in mind with links out to another btrfs that I am
failing to see.

Thanks,
Boris

> 
> BR
> G.Baroncelli
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
