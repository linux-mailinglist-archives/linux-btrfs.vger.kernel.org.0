Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97E9231599
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 00:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgG1WfQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 18:35:16 -0400
Received: from mailrelay3-3.pub.mailoutpod1-cph3.one.com ([46.30.212.12]:58366
        "EHLO mailrelay3-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729223AbgG1WfQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 18:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:subject:message-id:to:
         from:date:from;
        bh=7cRD8sbDD+Fdxn553zlVdltMZoE5KMxRBFpb9vfdHw8=;
        b=nk/IOX/M538CF9ol7yz1ribbpmT4lBDFJEjoCn1ToB1OA6bbiLrSp9FN5Vd5quAKmEeHvq1Dgkrc8
         sKslATva12Q7ZWr6eMqeYxN/EhgF+bd1N0yfsFwNxz8wi1rC1iL3hn6Cj85jbovcZ/3GoujQj+XCIF
         4mOclk9O0KJuytMimvdsfEkDbAmSH3YjzKkTGFIbOb4fjdVUPhJ2bw/18kETkMHCMn+jvJYpJhb0Pu
         vOp2XzOZf4dOtuIW96uKxXhJW8RXO/b+4mZWcS6HT/OA7HUbfYfRKMhMjR19kYUvLbf0XihPe9+Myn
         f0BXsppKDSR1KCmCygQO7Kw8Ghd9kWw==
X-HalOne-Cookie: 1af1d218c7d190e989f2c88fafa5506380b9bcec
X-HalOne-ID: 99ff3c1c-d122-11ea-86ea-d0431ea8bb03
Received: from [192.168.0.126] (h-131-138.a357.priv.bahnhof.se [81.170.131.138])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 99ff3c1c-d122-11ea-86ea-d0431ea8bb03;
        Tue, 28 Jul 2020 22:35:13 +0000 (UTC)
Date:   Wed, 29 Jul 2020 00:35:13 +0200 (GMT+02:00)
From:   A L <mail@lechevalier.se>
To:     linux-btrfs@vger.kernel.org
Message-ID: <5fede11.7708c836.1739790c2a0@lechevalier.se>
Subject: Official naming policy for Btrfs.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm wondering if there is an official naming declaration for Btrfs?

I note that on the wiki the capitalisation varies as 'Btrfs' or 'btrfs'.

Sections 1-4: Btrfs
From section 5: btrfs
https://btrfs.wiki.kernel.org/index.php/Main_Page

This man page is consistently using lower case. Obviously when referring to=
 the 'btrfs' it should be spelled exactly as the command line is.=20
https://btrfs.wiki.kernel.org/index.php/Manpage/mkfs.btrfs


I would feel better with a clean naming policy. I suggest 'Btrfs' should be=
 used, as in that is what is used in the logo. It also suggests that Btrfs =
is now a Name instead of an acronym for B-TreeFS.

Anders=20

