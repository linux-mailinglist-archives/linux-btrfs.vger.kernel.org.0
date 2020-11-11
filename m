Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A89C2AF72F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 18:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgKKRGZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 11 Nov 2020 12:06:25 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:34407 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgKKRGY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 12:06:24 -0500
Received: from [192.168.177.174] ([91.63.168.45]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1N1fag-1kAWvb2gUC-0124LN; Wed, 11 Nov 2020 18:06:19 +0100
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
Subject: Re[2]: raid 5/6 - is this implemented?
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Date:   Wed, 11 Nov 2020 17:06:23 +0000
Message-Id: <em7eedc683-088d-4d3d-84f8-786ac215e7bf@desktop-g0r648m>
In-Reply-To: <20201107014333.GA31381@hungrycats.org>
References: <emd2373acd-6dfe-4317-bdf7-402cb909bc3f@desktop-g0r648m>
 <20201107014333.GA31381@hungrycats.org>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/8.0.3385.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:lmQlAebS2775VtO/p+Aris2p9o39bawijY9X+lc4/2g60YsgqUL
 O+J8u8X4lSRYqjNowM/MsAMNAaNkBgRyxQOCv1zU2F5n5iNoHeTmSvK+M4K9Zvy1r0IpMFT
 M/3I12ULbOdcEHPU5ojSeEkPF233qA0XNNGlx43lxTyu/DsBq6Vd5J4wFu+lLnI3Mvb8SH4
 NeY6v3f2FbSEsG3srQbRw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qKVLtQIt/vk=:i9+vbKyBsWUI5Kzj5esAGn
 msly2ZTPyD9QPXs868FiTivpJxujDAVeDakZ9pe+IryVeIRSNO6jt4e8xkdYVURBs4BjYHPm+
 VOxugeXvgd8XkmVS5cn45sJFGyi0FdvRi6N+gFII3gWMce9K1YnsW7YHxUvgP+wrdAk6JOA/6
 VTJmVg5aXFY6bSqx1/F+Ig66AcAAttl68Y8QodutQPtebr1pblYtq2BxFc3EeKX1OfsPyiMlp
 PMsAjEqjLa2OZshRiEZFjgWnkY8YrYNnajiNfFXmPFBKXLNgvkN8fvPzATCF+emdzBONBU1A6
 NRQvZQPViREbpAzFoALAqxf4ErRyysip7vAPBFfR3TvLRB4CD4qyah7I6rcDLSE953JEPOSUB
 MDspNOTUR0bpu7PUIp8nzPIS9ILQTSIkSLsSN0jDmdK3dfU1mj/1F6xt6K2F3bkxYJkBgD8zd
 5hhSFGnRDg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Zygo,

thanks for your reply.

>It's not the last 50 generations that need to be scrubbed.  Any committed
>transaction since mkfs can be affected by write hole.
Reading your link below, I would say that raid5/6 should not be used 
currently.
But if it is and as long as the state is as it is, I think that a full 
scrub should be done after any unclean shutdown.
>
>See this more up to date list, which puts write hole right at the bottom:
>
>https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/
>
That is a really good post.
I think it should be made prominent on the btrfs wiki?!

Regards,
Hendrik


>

