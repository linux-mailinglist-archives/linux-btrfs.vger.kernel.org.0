Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6655768135
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2019 23:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfGNVAU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Jul 2019 17:00:20 -0400
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:35450 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728442AbfGNVAT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Jul 2019 17:00:19 -0400
X-Sender-Id: dreamhost|x-authsender|eric@ericmesa.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0BD0E501CE2;
        Sun, 14 Jul 2019 21:00:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a47.g.dreamhost.com (100-96-11-126.trex.outbound.svc.cluster.local [100.96.11.126])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BF8CC5019B0;
        Sun, 14 Jul 2019 21:00:11 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|eric@ericmesa.com
Received: from pdx1-sub0-mail-a47.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.3);
        Sun, 14 Jul 2019 21:00:16 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|eric@ericmesa.com
X-MailChannels-Auth-Id: dreamhost
X-Exultant-Trail: 0920015a0e10a38f_1563138012272_1094497337
X-MC-Loop-Signature: 1563138012272:3599939332
X-MC-Ingress-Time: 1563138012272
Received: from pdx1-sub0-mail-a47.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a47.g.dreamhost.com (Postfix) with ESMTP id 8EB2E82FEE;
        Sun, 14 Jul 2019 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ericmesa.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type; s=ericmesa.com; bh=fW3jXefwxCaiD+pXxiQbCs4caOk=; b=
        az9SR/jyFJ2bWHH0vth9vjlkuVeNjCEOfnqhKtamOyVErs6fFsLnJLQlBEegZNVh
        x7CCe0bx3ExOsOTWvOiCV6fEO2/lflbKLzerH71i9pNeV10LluhQ2KizV6tOohUF
        2fqXomOS+ygzjv/8ovzruBih5Ie7pZlwYCJc/OxO5+o=
Received: from supermario.mushroomkingdom (pool-68-134-39-132.bltmmd.fios.verizon.net [68.134.39.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: eric@ericmesa.com)
        by pdx1-sub0-mail-a47.g.dreamhost.com (Postfix) with ESMTPSA id 8544182FEC;
        Sun, 14 Jul 2019 14:00:03 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a47
From:   Eric Mesa <eric@ericmesa.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Issues with btrfs send/receive with parents
Date:   Sun, 14 Jul 2019 16:59:56 -0400
Message-ID: <10873243.P3z0pXWhJ5@supermario.mushroomkingdom>
In-Reply-To: <CAJCQCtRfADiHjG+r-1Gr=1bFw+c-u8-zi+bkLCO=jd5HnxjFDQ@mail.gmail.com>
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom> <97541737.v72oTHCfnW@supermario.mushroomkingdom> <CAJCQCtRfADiHjG+r-1Gr=1bFw+c-u8-zi+bkLCO=jd5HnxjFDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1651492.uCfOGT36Gn"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrheehgdduheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhggtgesghdtreertddtvdenucfhrhhomhepgfhrihgtucfovghsrgcuoegvrhhitgesvghrihgtmhgvshgrrdgtohhmqeenucfkphepieekrddufeegrdefledrudefvdenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepshhuphgvrhhmrghrihhordhmuhhshhhrohhomhhkihhnghguohhmpdhinhgvthepieekrddufeegrdefledrudefvddprhgvthhurhhnqdhprghthhepgfhrihgtucfovghsrgcuoegvrhhitgesvghrihgtmhgvshgrrdgtohhmqedpmhgrihhlfhhrohhmpegvrhhitgesvghrihgtmhgvshgrrdgtohhmpdhnrhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart1651492.uCfOGT36Gn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 13, 2019 11:55:05 PM EDT Chris Murphy wrote:
> On Thu, Jun 13, 2019 at 3:23 PM Eric Mesa <eric@ericmesa.com> wrote:
> > On Thursday, June 13, 2019 2:26:10 AM EDT Andrei Borzenkov wrote:
> > > All your snapshots on source have the same received_uuid (I have no idea
> > > how is it possible). If received_uuid exists, it is sent to destination
> > > instead of subvolume UUID to identify matching snapshot. All your backup
> > > sbapshots on destination also have the same received_uuid which is
> > > matched against (received_)UUID of source subvolume. In this case
> > > receive command takes the first found subvolume (probably the most
> > > recent, i.e. with the smallest generation number). So you send
> > > differential stream against one subvolume and this stream is applied to
> > > another subvolume which explains the error.
> > 
> > Yup. Any idea of how to fix?
> 
> Maybe 'cp -a --relink' into a new subvolume on the source. It won't
> complete immediately like a snapshot. But it'll complete way faster
> than a normal data copy. From that point, this new subvolume becomes
> "master" where all changes occur, and all the other snapshots are made
> from it.
> 
> Also, you should do incrementals between the most recent two
> snapshots. i.e. the snapshot that follows -p should be the snapshot
> most recently successfully received on the destination. That
> represents the least amount of increment needed to update the
> destination. It will work the way you're doing it now, with -p being
> an older snapshot, but you're unnecessarily sending a lot more data
> every time.
Just in case anyone is searching the net with the same issue, I want to 
confirm that this worked. Ever since moving to a clean /home subvol (didn't 
have a recieved_UUID) everything has worked perfectly with respect to the 
issue I'd emailed the mailing list about. 

-- 
--
Eric Mesa
--nextPart1651492.uCfOGT36Gn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEBs24pwhCu/Z7g0Sb2bE1K6FAnEUFAl0rl8wACgkQ2bE1K6FA
nEVf8ggAqz31vshAz8yb9N6L0YYoZohio8fteMoeq2GwXpuTXvVp5ywU860lp7pr
cOY6FQZO+UXu3YOl2ioQlGG1aPDFxJXFfD3TIagpRtY2Pg6LNyqPvU1HQi78nbGM
sGAx3kosf9HclseYpnnBO2pYIs9S7YqtYGQU/DPQBhM58/IRj1IX112QBrHf58MM
My6YSEevpZFnwBvnQVcibwbJooVPHOtufQCfUlBnkkhDbH1NIY+N1x86mu6oURbz
JjLpYn+zogVw6SIr8SQWpKyk4NfofsrJQFO3Kepr8HeyI2UoYU7EtQM9J37Mc1o+
2sB1FF7FpjRygpU6mIcg0/ICGgX/FQ==
=IixI
-----END PGP SIGNATURE-----

--nextPart1651492.uCfOGT36Gn--



