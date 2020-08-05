Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF11123C9F5
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Aug 2020 12:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgHEKf5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Aug 2020 06:35:57 -0400
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:42335 "EHLO
        10.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgHEK0G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Aug 2020 06:26:06 -0400
X-Greylist: delayed 3665 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2020 06:26:03 EDT
Received: from player698.ha.ovh.net (unknown [10.108.35.103])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 9FBC824694E
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Aug 2020 10:26:36 +0200 (CEST)
Received: from grubelek.pl (89-77-39-184.dynamic.chello.pl [89.77.39.184])
        (Authenticated sender: szarpaj@grubelek.pl)
        by player698.ha.ovh.net (Postfix) with ESMTPSA id DD40314FBD39D;
        Wed,  5 Aug 2020 08:26:34 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-100R00384ca6d86-a789-4c90-9a89-cc0c52ba36ca,
                    43C8D90AB0FB860757331F45AB9810A28CF922DC) smtp.auth=szarpaj@grubelek.pl
Received: by teh mailsystemz
        id C20B324EB28E; Wed,  5 Aug 2020 10:26:33 +0200 (CEST)
Date:   Wed, 5 Aug 2020 10:26:33 +0200
From:   Piotr Szymaniak <szarpaj@grubelek.pl>
To:     Edmund Urbani <edmund.urbani@liland.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Unable to remove missing device from RAID-6 due to csum error
Message-ID: <20200805082633.GA20177@pontus>
References: <febe56b5-6674-9706-1a04-ee49fb00aae5@liland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <febe56b5-6674-9706-1a04-ee49fb00aae5@liland.com>
X-Ovh-Tracer-Id: 7871166251743254253
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrjeekgddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddtjeenucfhrhhomheprfhiohhtrhcuufiihihmrghnihgrkhcuoehsiigrrhhprghjsehgrhhusggvlhgvkhdrphhlqeenucggtffrrghtthgvrhhnpedvffdvkeevvdehffeutddvveelueejgeefkeeuiedvfeevuddutdegfeetkeevteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedtrddtrddtrddtpdekledrjeejrdefledrudekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshiirghrphgrjhesghhruhgsvghlvghkrdhplhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 04, 2020 at 05:40:01PM +0200, Edmund Urbani wrote:
> Hi all,

Hi Edmund,

if this is not some follup thread, you should include more information
like described here:
https://btrfs.wiki.kernel.org/index.php/Btrfs_mailing_list


Best regards,
Piotr Szymaniak.
-- 
 - Spacer? - powtorzyl  pan  Capelli. - Chodzi ci o to,  kiedy stawiasz
jedna  noge  przed  druga i nie  przestajesz, poki nie znajdziesz sie z
powrotem w domu.
  -- Graham Masterton, "Mirror"
