Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9B52E6F66
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 10:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgL2Jfd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Dec 2020 04:35:33 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:56850 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725866AbgL2Jfc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 04:35:32 -0500
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id 1C0B3452;
        Tue, 29 Dec 2020 10:34:51 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1609234491;
        bh=N7GwpHe78KSuXqsmPGDPiRgXCZ90Q+LyE9Vbu2wlpl8=;
        h=Date:From:Subject:To:In-Reply-To:References;
        b=bBbTBJJ378TOmhfAs9/gbeyaW22DBOAsmjF5k0/6+qgWbi6F61rFZc4yHwnbHcbD9
         UrJecJSHEpuhzLFsFwBJ6VnSdX4ViqkFzpEMA8vtv78fRg76n+hzZVL0HNPK+M8cSK
         AgIOJsrlDpFDV52M0Swi8blOn22+lE8G8i1Zd0ao=
MIME-Version: 1.0
Date:   Tue, 29 Dec 2020 09:34:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs2@lesimple.fr>
Message-ID: <e471c466476658fd6c40cdaf71748d52@lesimple.fr>
Subject: Re: [PATCH] btrfs-progs: check: allow force v1 space cache
 cleanup even the fs has v2 space cache enabled
To:     "Qu Wenruo" <wqu@suse.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <20201229003035.13329-1-wqu@suse.com>
References: <20201229003035.13329-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

December 29, 2020 1:32 AM, "Qu Wenruo" <wqu@suse.com> wrote:=0A=0A> There=
 are cases where v1 free space cache is still left while user has=0A> alr=
eady enabled v2 cache.=0A> =0A> In that case, we still want to force v1 s=
pace cache cleanup in=0A> btrfs-check.=0A> =0A> This patch will remove th=
e v2 check if we're cleaning up v1 cache,=0A> allowing us to cleanup the =
leftover.=0A> =0A> Signed-off-by: Qu Wenruo <wqu@suse.com>=0A> ---=0A> ch=
eck/main.c | 6 ------=0A> 1 file changed, 6 deletions(-)=0A> =0A> diff --=
git a/check/main.c b/check/main.c=0A> index 8ad7f5886f06..f4755d260bfe 10=
0644=0A> --- a/check/main.c=0A> +++ b/check/main.c=0A> @@ -9917,12 +9917,=
6 @@ static int do_clear_free_space_cache(int clear_version)=0A> int ret =
=3D 0;=0A> =0A> if (clear_version =3D=3D 1) {=0A> - if (btrfs_fs_compat_r=
o(gfs_info, FREE_SPACE_TREE)) {=0A> - error(=0A> - "free space cache v2 d=
etected, use --clear-space-cache v2");=0A> - ret =3D 1;=0A> - goto close_=
out;=0A> - }=0A> ret =3D clear_free_space_cache();=0A> if (ret) {=0A> err=
or("failed to clear free space cache");=0A> -- =0A> 2.29.2=0A=0A=0AMaybe =
we should keep the message but make it not fatal?=0ASomething like "free =
space cache v2 detected, use --clear-space-cache v2 to clear it. Proceedi=
ng in clearing potential v1 leftovers as asked..."?=0A=0ARegards,=0A=0ASt=
=C3=A9phane.
