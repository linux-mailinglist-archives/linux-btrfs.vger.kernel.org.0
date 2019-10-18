Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13A53DCAED
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 18:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394732AbfJRQXf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 12:23:35 -0400
Received: from smtp1.rz.tu-harburg.de ([134.28.205.38]:37256 "EHLO
        smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJRQXf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 12:23:35 -0400
Received: from mail.tu-harburg.de (mail4.rz.tu-harburg.de [134.28.202.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.tuhh.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by smtp1.rz.tu-harburg.de (Postfix) with ESMTPS id 46vrts2YnPzxWl;
        Fri, 18 Oct 2019 18:23:33 +0200 (CEST)
Received: from mailspring.rz.tuhh.de (mailspring.rz.tuhh.de [134.28.202.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cmz7792@KERBEROS.TU-HARBURG.DE)
        by mail.tu-harburg.de (Postfix) with ESMTPSA id 46vrtr4tw2zJrC3;
        Fri, 18 Oct 2019 18:23:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2019-42;
        t=1571415813; bh=nKOWgjDXh84LPZJj4tgB2IQNl2JM83WOhVozqjHrawU=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=mBOMZgqCLtR2APAJbYbG+3/+20IygEABQt3OJxa0cV72OUqWVbeoNbgkpXyBD5coP
         duNHN4T0i+I/QemHmRJp1nPrw3t78q7wZKTSrgm4i6W8yS/rJzpUWKr37ZXKBufNAO
         vV++2/+ytRLi2Ap9nsG2mkUoW74BhcRlP4yzokkw=
Date:   Fri, 18 Oct 2019 18:23:31 +0200
From:   Merlin =?UTF-8?B?QsO8Z2U=?= <merlin.buege@tuhh.de>
To:     merlin.buege@tuhh.de
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v2] btrfs-progs: small fixes/cleanup in Documentation
Message-ID: <20191018182331.1786ee9f.merlin.buege@tuhh.de>
In-Reply-To: <20191018161433.148176-1-merlin.buege@tuhh.de>
References: <20191017045006.130378-1-merlin.buege@tuhh.de>
        <20191018161433.148176-1-merlin.buege@tuhh.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Fri, 18 Oct 2019 18:14:33 +0200
Merlin B=C3=BCge <merlin.buege@tuhh.de> wrote:
...
> diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5=
.asciidoc
> index 6a1a04b7..ee6010fe 100644
> --- a/Documentation/btrfs-man5.asciidoc
> +++ b/Documentation/btrfs-man5.asciidoc
...
> @@ -659,7 +653,7 @@ swapfile extents or may fail:
...
> -* device replace - dtto
> +* device replace - ditto

I think I may have got that last one wrong, sorry.
I've never seen it spelled 'dtto', but I now see further references e.g.
here:
https://github.com/kdave/btrfs-progs/blob/master/Makefile

So, feel free to pick v1/v2 which you find the most appropriate!

Thanks.
--=20
Merlin B=C3=BCge
