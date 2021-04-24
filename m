Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A654D36A18C
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Apr 2021 16:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhDXOOv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Apr 2021 10:14:51 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40471 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhDXOOR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Apr 2021 10:14:17 -0400
X-Originating-IP: 87.154.223.3
Received: from luna.localnet (p579adf03.dip0.t-ipconnect.de [87.154.223.3])
        (Authenticated sender: chainofflowers@neuromante.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D0ACA20009;
        Sat, 24 Apr 2021 14:13:37 +0000 (UTC)
From:   chainofflowers <chainofflowers@neuromante.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Forza <forza@tnonline.net>,
        linux-btrfs@vger.kernel.org, Justin.Brown@fandingo.org,
        Qu Wenruo <wqu@suse.com>
Subject: Re: Access Beyond End of Device & Input/Output Errors
Date:   Sat, 24 Apr 2021 16:13:32 +0200
Message-ID: <1706720.PQSuIbNzif@luna>
Organization: neuromante.net
In-Reply-To: <e229a858-79c2-0416-6ab8-14b56177b21d@suse.com>
References: <5975832.dRgAyDc8OP@luna> <dea68577-4f60-afd2-753b-1fec3c13494d@neuromante.net> <e229a858-79c2-0416-6ab8-14b56177b21d@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1666762.KB4Oa1mW8t"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart1666762.KB4Oa1mW8t
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: chainofflowers <chainofflowers@neuromante.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org, Justin.Brown@fandingo.org, Qu Wenruo <wqu@suse.com>
Subject: Re: Access Beyond End of Device & Input/Output Errors
Date: Sat, 24 Apr 2021 16:13:32 +0200
Message-ID: <1706720.PQSuIbNzif@luna>
Organization: neuromante.net
In-Reply-To: <e229a858-79c2-0416-6ab8-14b56177b21d@suse.com>
References: <5975832.dRgAyDc8OP@luna> <dea68577-4f60-afd2-753b-1fec3c13494d@neuromante.net> <e229a858-79c2-0416-6ab8-14b56177b21d@suse.com>

On Samstag, 24. April 2021 02:25 Qu Wenruo wrote:
> But if that's the case, btrfs-check should be able to report such
> problem from the very beginning.

btrfs check was only reporting that "the cache would have been invalidated", I 
don't know if that was enough to suggest that a cache clear was needed. I 
assumed it would have done it automatically the next time the volume was 
mounted, that's why I didn't clean it... "pro-actively".

Could "clear-ino-cache" have helped, or not at all?


(c)


--nextPart1666762.KB4Oa1mW8t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE7WtRf7D+uIe8ZjG8QN5P8lNOVXMFAmCEJ4wACgkQQN5P8lNO
VXMDxBAAoi0PzSox4/NzWbQaJlH8S6eGDJpQix2XWEzfDyaOl01hbUGQRC54q8BY
ggXfyhMVS5ts5EXIzOm+O2xVNo6AWpMC8hgffLAetk84gYqAp6AzmIOq8nvq+Rrm
dTsbr8tzmUf5QyNwalE4a7ctQVsU+vyCU9787NhdnmvulzvcEe1NsDt6ECUTbZjk
QXk0R+qlQX3CppppiLTXBoTExqyYMbD5RFHs85xorYopk1e1cvpsLbBSLH/nVn2Z
oIQB4kC7QI4TBAhE1BW1ApR7tHDyH6Rm+hbzqUubgK+gauhm0eu1nfwcwlMdyQhd
/mcnxXrWn2G3acPnnxKIOkuz8oTLc0diIE/MgwAUxbrD4sOlldiTW2GlE/vzOZyZ
D0nN1ZQj3mF2Ldb6vE2AkWD5btgy9f5PFFAWc/a7Z2rEZTcvdArwuVj0AwclLqPu
4K68AfgKRouNTJ4lWFiVjUQ9Zo3P+/PVpu32j+/raneMI96Bz1SbnOBAbG0wWj4l
Wi2kelZScUcdwxVKZIKfwYnxdhjHCZXp4H7ULTk2QoEOjli984e1nd921Di/cplD
E0Efbj68jYNIsx/H1xGipgUseGAh6NB9NLexMjwAf8kNF69QtebBPt1zMWzYDsHQ
NGlAiFLNTxhMzDjOmCK5/mhDlXT52Ow8bQg2LFhq6O+qrleCsCY=
=0v0R
-----END PGP SIGNATURE-----

--nextPart1666762.KB4Oa1mW8t--



