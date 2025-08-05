Return-Path: <linux-btrfs+bounces-15845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97BFB1ABE0
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 03:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4363B24AB
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 01:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2941C86328;
	Tue,  5 Aug 2025 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tutanota.com header.i=@tutanota.com header.b="Ga/cdJR6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4CE24B29
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754355738; cv=none; b=SkxyTcXpmCMkSIWbrHezwQ4TJ7KvffetLX2VBsW1+I+Bov0qOyAHc42R8kxm/kx+IE7OG+TgwzKWxodUayeC2NkXD2EGNXD4et+OskGg0uaPq2jv0375k6o5ADmNP9AVfutZjH+OKR4e8/QmysUlOWlsM7zY7bk/iiZyjQinbyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754355738; c=relaxed/simple;
	bh=V3RKIAMqATp59D0/OIhUN94js2od53Kyj9qpcgMcxhs=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=hk7AZ5kKaghhgPi1QnxgPCoQkmY8eCpj4irnOlFfJ5IwttVVmoZx/JSuIuUdPQjgqCxW7xL3QcgYZ9xd1JVIVno56ca9yWUWKw5mBGNB/TslIYASkOfIr4LL4VfsWvb3tUvXlEFdtvbmaHarmHXWp0whI9HUpSQPme2DFZEbBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutanota.com; spf=pass smtp.mailfrom=tutanota.com; dkim=pass (2048-bit key) header.d=tutanota.com header.i=@tutanota.com header.b=Ga/cdJR6; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutanota.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutanota.com
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id A4C21AE3FF93
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 03:02:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754355729;
	s=s1; d=tutanota.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=R6f1qW29LIWac/WKMA+vnGVPmyAJHzkoJkSs1RKdTaE=;
	b=Ga/cdJR6nc7Egyy0SOWa7/u3AUj5LO2OEaldD2dxc6aUGnkF0AnAhOLhBdC6v7g1
	dWBtt0GXl6WyqjrIuVCVpUlQfvZ6pM+x2W7rupCTn+XC7jXuUanIlPfvlycyys6j+eJ
	wLxERBq0iJEQs/6lbOX7ROGmMQM9uJ1YNyiIOpGmMmd5eHf/mpbbzLBiYi1eopQ0BwK
	w9HlxO48bEh41qoY745spSGpFqSgvGD5KV4JxyjZcCt9ren+WGGkFNuXjRiBK8BdZls
	nlmEAWq+dIDSdRRRnix2ZPxLnN5rBLQ9UTsHeM5g9ysLIQPpxepf/60mpYpNrCOTHK6
	Lfl4kzoUdA==
Date: Tue, 5 Aug 2025 03:02:09 +0200 (GMT+02:00)
From: Josh Rodgers <joshrodgers@tutanota.com>
To: Linux Btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <OWrk-6K--F-9@tutanota.com>
Subject: Corrupted btrfs?
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_357031_1597889103.1754355729669"

------=_Part_357031_1597889103.1754355729669
Content-Type: multipart/alternative; 
	boundary="----=_Part_357032_1784071248.1754355729669"

------=_Part_357032_1784071248.1754355729669
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I had an issue with my unraid server where after upgrading to 7.0.1 my cach=
e drive is showing unmountable or no filesystem. I ran a btrfs check and i =
received the attached output from that check. I wanted to consult the exper=
ts before doing any repair.=C2=A0
Thank you,

Josh Rodgers

------=_Part_357032_1784071248.1754355729669
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
<div dir="auto">I had an issue with my unraid server where after upgrading to 7.0.1 my cache drive is showing unmountable or no filesystem. I ran a btrfs check and i received the attached output from that check. I wanted to consult the experts before doing any repair.&nbsp;</div><div dir="auto"><br></div><div dir="auto">Thank you,<br></div><div dir="auto"><br></div><div dir="auto">Josh Rodgers<br></div>  </body>
</html>

------=_Part_357032_1784071248.1754355729669--

------=_Part_357031_1597889103.1754355729669
Content-Type: text/plain; charset=us-ascii; name="BTRFS Check.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="BTRFS Check.txt"

sudo btrfs check --readonly /dev/nvme0n1p1
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p1
UUID: 0d842f39-ee87-4941-ad71-ee07ec699fb0
[1/8] checking log
[2/8] checking root items
[3/8] checking extents
inline extent refs out of order: key [10259591802880,168,4096]
data extent[10259591802880, 4096] referencer count mismatch (root 5 owner 32702817 offset 258048) wanted 0 have 1
data extent[10259591802880, 4096] referencer count mismatch (root 5 owner 32688097 offset 258048) wanted 0 have 1
data extent[10259591802880, 4096] referencer count mismatch (root 5 owner 32660600 offset 258048) wanted 0 have 1
data extent[10259591802880, 4096] bytenr mimsmatch, extent item bytenr 10259591802880 file item bytenr 0
data extent[10259591802880, 4096] referencer count mismatch (root 5 owner 32660600 offset 1306624) wanted 1 have 0
data extent[10259591802880, 4096] referencer count mismatch (root 5 owner 32674309 offset 258048) wanted 0 have 1
data extent[10259591802880, 4096] referencer count mismatch (root 5 owner 32645602 offset 258048) wanted 0 have 1
data extent[10259591802880, 4096] referencer count mismatch (root 5 owner 32598439 offset 258048) wanted 0 have 1
backpointer mismatch on [10259591802880 4096]
ERROR: errors found in extent allocation tree or chunk allocation
[4/8] checking free space tree
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 84019183616 bytes used, error(s) found
total csum bytes: 60546480
total tree bytes: 489340928
total fs tree bytes: 323567616
total extent tree bytes: 81166336
btree space waste bytes: 92348555
file data blocks allocated: 1082956144640
 referenced 87034966016
------=_Part_357031_1597889103.1754355729669--

