Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77AE22FF2E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 03:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgG1B6X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 21:58:23 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38561 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbgG1B6V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 21:58:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 761BA5C005E;
        Mon, 27 Jul 2020 21:58:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 27 Jul 2020 21:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:to:cc:subject:from:date
        :message-id:in-reply-to; s=fm1; bh=Nc2nupnSfk1A8BrW0HSbGcKbqGtZ7
        WNkRowoAM3KIxs=; b=eXqncfmLtqPEvWnzkGQVxEZ6XK8qZHE7wLj+oaSZw52PE
        j9ggJXobNbO4KatRMOvYa8kodH3urfaMLXvJcBabXR0GeXE/Yt3lDz7joEzs75/Q
        akIU91aoklqPBzoP9RmS16I0/WgiDg4ETNgzGWCtN0LpECMkJXq1ZDUJl91Dtu46
        IFxycvbSyDYWYMWmYa1oZRTxhiceWTuiebmBrgnz7+Z4SOOht0J54gKU/59ce5S8
        5DkFq85xH3QINbrup1xAIndIy68jMGoZtRzMdldfC7U65+sWuBkMNr/LXGEoSZRx
        uvrTX5gj/sRlJoYasJ5ZIX8uv0qel28nowCVTXOzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Nc2nup
        nSfk1A8BrW0HSbGcKbqGtZ7WNkRowoAM3KIxs=; b=o/Z3A2drvNl/6Oiz5zWszQ
        mQ0xUnqukcHEwuNCIRA1EzuplIpb2fd+WcxRiq+XSEd5ZEp8/xLU2z0Pcmt59AZs
        n5PtCNsjrYS46kEZtGIsczZqTS8GxhQR9zvQPxZpqdn4ESx4mpvnv1tGKFba53QZ
        oiwv61MMMrk6SgsGzs/LjE1NcXhcVY8iaOHjEPdyxiorA240FZusbN+jjVBbL6ZZ
        KxqzRTIiYe8FIfAEnC/5HS+x/1YKPKlWLQBBqJtmtZVngajPl/uQwx9ZhpgyB5UR
        vURMsX48q2pT/Fgtl1T7Gok1n775494VZ+jfFenV86g46jnXSnal9HtJczQym34g
        ==
X-ME-Sender: <xms:PIYfX7ooZEDAH3akfqC7WgUnCUx6XxRr8_I1Z99WBAVwjhRxdLRyUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedriedugdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhepgfgtvf
    fuhfffkfgjsehtqhertddttdejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepkedujeekteeufefggeehfe
    fhkeehueekfedtleekffektdeugefhveffjeehgedtnecuffhomhgrihhnpegvughithho
    rhgtohhnfhhighdrohhrghenucfkphepjeefrdelfedrvdegjedrudefgeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhu
    rdighiii
X-ME-Proxy: <xmx:PIYfX1qPqobznHpBQBDPoNVFn9qVcQNYnAGFa8-GJ8ChSUGomRCl6Q>
    <xmx:PIYfX4M9wr1iNd3wdN93JdzdckzWC-ZRJOEs8pv0G2sQ2tZ_vGg2pg>
    <xmx:PIYfX-5On-Lm-7DVDChAhyWjB1wlBbYENpK73eWNc_QlmOekxm84tQ>
    <xmx:PIYfX3WTy1hhOpj-cbrNqmiLHR0w3s3SMI7G-EhcxP-M52b4icQyIw>
Received: from localhost (c-73-93-247-134.hsd1.ca.comcast.net [73.93.247.134])
        by mail.messagingengine.com (Postfix) with ESMTPA id E0B7E30600B2;
        Mon, 27 Jul 2020 21:58:19 -0400 (EDT)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>, <linux-btrfs@vger.kernel.org>
Cc:     <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs-progs: Add basic .editorconfig
From:   "Daniel Xu" <dxu@dxuuu.xyz>
Date:   Mon, 27 Jul 2020 18:57:49 -0700
Message-Id: <C4HVUTNYQET4.4TPF6OOS3TQ3@maharaja>
In-Reply-To: <349343e3-8687-d217-66f8-59d50e8a8ced@gmx.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon Jul 27, 2020 at 6:57 PM PDT, Qu Wenruo wrote:
>
>
> On 2020/7/28 =E4=B8=8A=E5=8D=889:50, Qu Wenruo wrote:
> >=20
> >=20
> > On 2020/7/28 =E4=B8=8A=E5=8D=889:24, Daniel Xu wrote:
> >> Not all contributors work on projects that use linux kernel coding
> >> style. This commit adds a basic editorconfig [0] to assist contributor=
s
> >> with managing configuration.
> >>
> >> [0]: https://editorconfig.org/
> >=20
> > I like the idea of the generic style file.
> > It's just one single file for all editors.
> >=20
> > Although most btrfs developers I know use vim, and it's not supported
> > natively, it shouldn't be a big problem, a plugin would handle it
> > without problem.
> >=20
> >>
> >> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> >=20
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> >=20
> > But a small nitpick inlined below.
> >=20
> >> ---
> >>  .editorconfig | 10 ++++++++++
> >>  .gitignore    |  1 +
> >>  2 files changed, 11 insertions(+)
> >>  create mode 100644 .editorconfig
> >>
> >> diff --git a/.editorconfig b/.editorconfig
> >> new file mode 100644
> >> index 00000000..2829cfbe
> >> --- /dev/null
> >> +++ b/.editorconfig
> >> @@ -0,0 +1,10 @@
> >> +[*]
> >> +end_of_line =3D lf
> >> +insert_final_newline =3D true
> >> +trim_trailing_whitespace =3D true
> >> +charset =3D utf-8
> >> +indent_style =3D space
>
> Wait for a minute, does that mean, we use space as indent?
> IIRC kernel code style goes tab if possible?
>
> Thanks,
> Qu

Sorry, that was mistake. Just sent out a V2 before I saw your email.

Thanks,
Daniel
