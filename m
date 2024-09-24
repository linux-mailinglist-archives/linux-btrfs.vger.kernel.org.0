Return-Path: <linux-btrfs+bounces-8203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACA2984B92
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 21:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A168285430
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 19:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028AF13BAEE;
	Tue, 24 Sep 2024 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b="WknYZJ3A";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="etuZsaw1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from a4-15.smtp-out.eu-west-1.amazonses.com (a4-15.smtp-out.eu-west-1.amazonses.com [54.240.4.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33D1A4F0C
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.4.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206189; cv=none; b=qb1ZFjufmzOM6A/nxHRlif2wG0fFLEdu8dz96aeb5cfgw7zzhabYhbYboA11Np6R/eP9wH9p6rkDmzuYQ0t3bNaDNqzHvpRhS6xEkPjpC8Z8Jiym0dqerSCY804AMMliUdKP5fzlkunEzfRELw8gNGvTdeRT41r9aMh95caZf9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206189; c=relaxed/simple;
	bh=GVhqIwTGb0WaPvOCm0zl3ltfnY+bIpKQ2cWt8F0ruc8=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=cRBhrmJQscxnW7ckC1eT20TEsbWuDifblkRHueYz86DBIHmFqJmHGYouAj8bY23QByWfk0Eu/G1fosQl92aSsqSfM8i/2+L+8FJsIgXpGbFfyXR53BrBof2nW6o5y5j9rmayjRv+Y/1nnSLxMzt0Yv2yKL8QzIfHOgxsSoQf0mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org; spf=pass smtp.mailfrom=bounce.urbackup.org; dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b=WknYZJ3A; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=etuZsaw1; arc=none smtp.client-ip=54.240.4.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.urbackup.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1727206185;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject;
	bh=GVhqIwTGb0WaPvOCm0zl3ltfnY+bIpKQ2cWt8F0ruc8=;
	b=WknYZJ3AXQrwxnRf9hgPMeQpoTTQ3Tb/fHefqprlHyj0C3uDdjgXubl85DdbqmKD
	kaWfZs1xfYMGehx/Vz46Vojz3Qaei3UJy0TdITpoos4araW2zBYpzBcgWvzckHSN5rh
	Qc6i0ya83MH3yRRAXQ2cX8ErZjzRhy6f+83FetBE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1727206185;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject:Feedback-ID;
	bh=GVhqIwTGb0WaPvOCm0zl3ltfnY+bIpKQ2cWt8F0ruc8=;
	b=etuZsaw1JLTvUvZO+vaz9KhVkoTbIap6OeH61USkQ7pjwcgqdSRqAy4y9C4U/5t9
	tHyowI0W7YZYuW1f+0ZOu489X/qAJ86Uy6g//k51Yk9IhjTSXgxFpRY4nO/VOoAzWpx
	DSwFnmQXsRLMvm/FyiMGWsUW23owCDBx6uNbKo1I=
Content-Type: multipart/mixed; boundary="------------rz5AJPCvA4QF4K4kEBHhsVrN"
Message-ID: <010201922582d9b7-d7ef099b-176f-4799-a54c-ff43cda585aa-000000@eu-west-1.amazonses.com>
Date: Tue, 24 Sep 2024 19:29:45 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Martin Raiber <martin@urbackup.org>
Subject: About one million subvols limit
Feedback-ID: ::1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2024.09.24-54.240.4.15

This is a multi-part message in MIME format.
--------------rz5AJPCvA4QF4K4kEBHhsVrN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

one btrfs user ran into a problem when creating a snapshot where the 
snapshot creation returns "Too many open files" (EMFILE).

I did some digging in this mailing list and saw a case where someone 
else had the same issue and it was diagnosed to a limitation to the 
number of anon bdevs which has max 2^20 (about one million) bdevs and it 
was fixed insofar that the limit was increased (3x?) and it wasn't 
remounting read-only in case of this occuring. Thanks for this!

The user had about one million total subvols (in different file 
systems), so it is probably the same issue.

It is problematic that this limitation exists. Did some further digging 
and found 
https://lore.kernel.org/linux-bcachefs/20240222154802.GA1219527@perftesting/ 
. Perhaps we can come up with an accelerated plan to increase the 
possible number of subvols? E.g. the behaviour could be switched over 
via a mount flag or feature bit?

Also attached a possible patch which would increase the max number of 
bdevs to 2^31, significantly improving the situation, but I'm 
insufficiently involved to tell if this might cause obvious problems.

I've also noticed that each subvol uses 2K of kernel memory, so 2^31 
subvols would use 4TiB of RAM -- so that would be the limitation for now 
(would be great if that can be improved as well, but that would be 
another topic).

Regards,

Martin Raiber




--------------rz5AJPCvA4QF4K4kEBHhsVrN
Content-Type: text/plain; charset=UTF-8;
 name="0001-Increase-possible-number-of-anon-bdevs.patch"
Content-Disposition: attachment;
 filename="0001-Increase-possible-number-of-anon-bdevs.patch"
Content-Transfer-Encoding: base64

RnJvbSA3MmFmZGUyOGEyYmY2NjU2ZDkyMWEzODk3NTU1NTY4YjhlOTJlYjEzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJ0aW4gUmFpYmVyIDxtYXJ0aW5AdXJiYWNrdXAu
b3JnPgpEYXRlOiBUdWUsIDI0IFNlcCAyMDI0IDIxOjE5OjAwICswMjAwClN1YmplY3Q6IFtQ
QVRDSCAxLzFdIEluY3JlYXNlIHBvc3NpYmxlIG51bWJlciBvZiBhbm9uIGJkZXZzCgpDdXJy
ZW50bHkgb25seSBtYXggMl4yMCBhbm9uIGJkZXZzIGNhbiBiZSBhbGxvY2F0ZWQuCkluY3Jl
YXNlIHRoaXMgYnkgYWxzbyB1c2luZyB0aGUgdXBwZXIgcG9ydGlvbiBvZiB0aGUKbWFqb3Ig
ZGV2aWNlIG51bWJlciBmb3IgYW5vbiBiZGV2cyAobW9zdCB1cHBlcgpiaXQgc2V0KS4gU2lu
Y2UgY3VycmVudGx5IG1ham9yIGRldmljZXMgc2VlbSB0byBiZQpudW1iZXJlZCA8IDUxMiB0
aGlzIHNob3VsZG4ndCBjYXVzZSBpc3N1ZXMuCi0tLQogZnMvc3VwZXIuYyB8IDE2ICsrKysr
KysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3N1cGVyLmMgYi9mcy9zdXBlci5jCmluZGV4IDJk
NzYyY2U2N2Y2ZS4uMGMwMzBiZmMwNGRhIDEwMDY0NAotLS0gYS9mcy9zdXBlci5jCisrKyBi
L2ZzL3N1cGVyLmMKQEAgLTEyNTcsMjYgKzEyNTcsMzYgQEAgc3RhdGljIERFRklORV9JREEo
dW5uYW1lZF9kZXZfaWRhKTsKIGludCBnZXRfYW5vbl9iZGV2KGRldl90ICpwKQogewogCWlu
dCBkZXY7CisJdW5zaWduZWQgaW50IGRldl9tYWo7CiAKIAkvKgogCSAqIE1hbnkgdXNlcnNw
YWNlIHV0aWxpdGllcyBjb25zaWRlciBhbiBGU0lEIG9mIDAgaW52YWxpZC4KIAkgKiBBbHdh
eXMgcmV0dXJuIGF0IGxlYXN0IDEgZnJvbSBnZXRfYW5vbl9iZGV2LgogCSAqLwotCWRldiA9
IGlkYV9hbGxvY19yYW5nZSgmdW5uYW1lZF9kZXZfaWRhLCAxLCAoMSA8PCBNSU5PUkJJVFMp
IC0gMSwKKwlkZXYgPSBpZGFfYWxsb2NfcmFuZ2UoJnVubmFtZWRfZGV2X2lkYSwgMSwgKDEg
PDwgKE1JTk9SQklUUyArIDExKSApIC0gMSwKIAkJCUdGUF9BVE9NSUMpOwogCWlmIChkZXYg
PT0gLUVOT1NQQykKIAkJZGV2ID0gLUVNRklMRTsKIAlpZiAoZGV2IDwgMCkKIAkJcmV0dXJu
IGRldjsKIAotCSpwID0gTUtERVYoMCwgZGV2KTsKKwlkZXZfbWFqID0gTUFKT1IoZGV2KTsK
KwlpZiAoZGV2X21haj09MCkKKwkJKnAgPSBNS0RFVigwLCBNSU5PUihkZXYpKTsKKwllbHNl
IC8vIEFsc28gdXNlIGhpZ2hlc3QgYml0IGluIE1BSk9SIGZvciBhbm9uIGRldmljZXMKKwkJ
KnAgPSBNS0RFViggMVU8PDMxIHwgZGV2X21haiwgTUlOT1IoZGV2KSk7CiAJcmV0dXJuIDA7
CiB9CiBFWFBPUlRfU1lNQk9MKGdldF9hbm9uX2JkZXYpOwogCiB2b2lkIGZyZWVfYW5vbl9i
ZGV2KGRldl90IGRldikKIHsKLQlpZGFfZnJlZSgmdW5uYW1lZF9kZXZfaWRhLCBNSU5PUihk
ZXYpKTsKKwlpZiAoZGV2ICYgKDFVPDwzMSkpCisJCWRldiAmPSB+KDFVPDwzMSk7CisJZWxz
ZQorCQlkZXYgPSBNSU5PUihkZXYpOworCisJaWRhX2ZyZWUoJnVubmFtZWRfZGV2X2lkYSwg
ZGV2KTsKIH0KIEVYUE9SVF9TWU1CT0woZnJlZV9hbm9uX2JkZXYpOwogCi0tIAoyLjMwLjIK
Cg==

--------------rz5AJPCvA4QF4K4kEBHhsVrN--

