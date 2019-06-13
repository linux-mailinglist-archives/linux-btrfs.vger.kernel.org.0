Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D13B44E50
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2019 23:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfFMVXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 17:23:09 -0400
Received: from dog.birch.relay.mailchannels.net ([23.83.209.48]:22269 "EHLO
        dog.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbfFMVXJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 17:23:09 -0400
X-Sender-Id: dreamhost|x-authsender|eric@ericmesa.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5454E3421FD;
        Thu, 13 Jun 2019 21:23:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a53.g.dreamhost.com (100-96-14-97.trex.outbound.svc.cluster.local [100.96.14.97])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C02ED341A62;
        Thu, 13 Jun 2019 21:23:06 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|eric@ericmesa.com
Received: from pdx1-sub0-mail-a53.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.2);
        Thu, 13 Jun 2019 21:23:07 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|eric@ericmesa.com
X-MailChannels-Auth-Id: dreamhost
X-Callous-Grain: 1bc6cd952862852e_1560460987138_1223024384
X-MC-Loop-Signature: 1560460987138:2684021214
X-MC-Ingress-Time: 1560460987137
Received: from pdx1-sub0-mail-a53.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a53.g.dreamhost.com (Postfix) with ESMTP id 6CB86809E9;
        Thu, 13 Jun 2019 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ericmesa.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type; s=ericmesa.com; bh=ZP4jBeOmxI+rQnRSpAO1Qq9unT0=; b=
        JKUjooANC6nvWEt/jivJUzB877jRTUujweBAiHPJ5lSrG1oNqPatepMN6AuxMLM4
        UowEu8juqbuAT1POE06pdZ/zyNjPct+fHog+wR8ABkAAsUiEzQ2sTtoX1qS5bYOy
        TlwPLHXII21wfnjqdZoMDwBSoIn2lbLaPXqvR1VWGHA=
Received: from supermario.mushroomkingdom (pool-68-134-39-132.bltmmd.fios.verizon.net [68.134.39.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: eric@ericmesa.com)
        by pdx1-sub0-mail-a53.g.dreamhost.com (Postfix) with ESMTPSA id 98674809DD;
        Thu, 13 Jun 2019 14:23:00 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a53
From:   Eric Mesa <eric@ericmesa.com>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Issues with btrfs send/receive with parents
Date:   Thu, 13 Jun 2019 17:22:56 -0400
Message-ID: <97541737.v72oTHCfnW@supermario.mushroomkingdom>
In-Reply-To: <b2bba48e-a759-cb99-cf2c-04e89bce171e@gmail.com>
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom> <2331470.mWhmLaHhuV@supermario.mushroomkingdom> <b2bba48e-a759-cb99-cf2c-04e89bce171e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3800452.NEQRHaf9XN"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehledgudeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfgggtsehgtderredttddvnecuhfhrohhmpefgrhhitgcuofgvshgruceovghrihgtsegvrhhitghmvghsrgdrtghomheqnecukfhppeeikedrudefgedrfeelrddufedvnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehsuhhpvghrmhgrrhhiohdrmhhushhhrhhoohhmkhhinhhgughomhdpihhnvghtpeeikedrudefgedrfeelrddufedvpdhrvghtuhhrnhdqphgrthhhpefgrhhitgcuofgvshgruceovghrihgtsegvrhhitghmvghsrgdrtghomheqpdhmrghilhhfrhhomhepvghrihgtsegvrhhitghmvghsrgdrtghomhdpnhhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart3800452.NEQRHaf9XN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 13, 2019 2:26:10 AM EDT Andrei Borzenkov wrote:
> 
> All your snapshots on source have the same received_uuid (I have no idea
> how is it possible). If received_uuid exists, it is sent to destination
> instead of subvolume UUID to identify matching snapshot. All your backup
> sbapshots on destination also have the same received_uuid which is
> matched against (received_)UUID of source subvolume. In this case
> receive command takes the first found subvolume (probably the most
> recent, i.e. with the smallest generation number). So you send
> differential stream against one subvolume and this stream is applied to
> another subvolume which explains the error.

Yup. Any idea of how to fix? 

--
Eric Mesa
--nextPart3800452.NEQRHaf9XN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEBs24pwhCu/Z7g0Sb2bE1K6FAnEUFAl0CvrAACgkQ2bE1K6FA
nEUbjggAxYfloJcHc8SNuK04jl5/MF/R13BsyI4tYRGSRA0FGs8cRajmgQfrDGXC
eT5ndzndVjqd64c3kbxZaoTO7pUkMXwRUYgG8rf8lb3puNFlVpbXdeEoI2PpMciI
gSBGTu09mMl82RTmz4zVQ1uui4ABRQ2JM8ZaG5z2n1Whf0+XDJ1pMd1x8BV23F25
YjRSOCPsGJEOuFhHxEQIxDIncnJGLb3zupSZPOzsvBM9TVAMR4+IVu8m2mQmykAk
FSpVGZzgW1vZMZAwIcfV7HXPCPpTChBOT5luHeXHhiNazFHMPJ1bn9/kzR7UARme
qtxgC7SiZUIKHWh4xNRI6zkoiVVoSQ==
=VQUx
-----END PGP SIGNATURE-----

--nextPart3800452.NEQRHaf9XN--



