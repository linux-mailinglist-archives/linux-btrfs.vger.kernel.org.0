Return-Path: <linux-btrfs+bounces-14541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CBDAD0D0F
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jun 2025 13:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F43188F494
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jun 2025 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072F4220699;
	Sat,  7 Jun 2025 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QooI0x5Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20FDEC4
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Jun 2025 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749295206; cv=none; b=t7z+9g8lnJhf3nfceALCZkQ+jCZuVmMMBUJqg8YQCEwCk7aUyZDiKwZtkX0CmSrvaHv4sJjV/WoN9lccZYFKN2xYHTZbsc40jVCNjJyJhKXXs7a1Cb5dhM6d8u0wJQ1DfWXD7X/FjfAFLEk+50gZC7PFbweKzc3xvc+C08WkDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749295206; c=relaxed/simple;
	bh=uykssuTMyYpC0FOYmAa9do9te5/Yb3iSp4QRB8LTdAk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UCcPVeXBZKFNqXJBnObQ4JpSwAW8kFHnwO+JTyyj2sv3sTjg/8UDtJjj7E495M9H20npZOEJXGvQg8zEJ/C0Nm965DJFQQ6CUOTFzMcLGFIuSL+Qd9dgXKKpCEqn7InPa/dMCk740sGA+KeolF0ueMuM5wBYJySHnDLzU99TfgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QooI0x5Y; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e771347693so1180801137.1
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Jun 2025 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749295203; x=1749900003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tudgey6ZL6GNA6z89mMpbd9CtrQDT/5gyFkqzZJJ6m8=;
        b=QooI0x5YBfZt0WUGJiuffA26BPsewR2nAFYY+RkNnpCAEXjgCuUQPQPhwXrlTwckV0
         yJj88w2E9SseeRmdrj7EBO3myaFji8EFz3aBoaWD3WRcJvH9X3R+q9hKTusGZ/YMJeFM
         UapconIlpgJE9XdBjtFMNVGqZdBf5M/cLVjxRysU6A+K8tTsR8p8bL+fAiNZZ42AytwK
         qjQSUoPU6XQW+ogOTheuTUS6Agq0nO4dfEcduqnbTy9AySKaY5BUtqLr4t/Wi6xRebxD
         PRie7qN4vD/7fI7B08xartKFxTNB5GLVaQAQD9zKEPANqO+FJ07vjUAGEzMG4IpQ60JG
         l7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749295203; x=1749900003;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tudgey6ZL6GNA6z89mMpbd9CtrQDT/5gyFkqzZJJ6m8=;
        b=ALsQCNJ6ptqpzSR1JliZaWAilBTtxXLZ5+f/NB5FRgjOvYYFCKVhVfdLZsBQ2WTgQ7
         dCw/Zukhco11KbjF97cHmo4MjtNcawkwKIi3aFdlcSbiaySgO2E8aDQ4W7l/fEb8SFrz
         5zujWM5Zwi5gKwJibo227712iGsVW3vNDHTk40h/vqMsM2UtUgTTucPQGLfXJtauRqPO
         HoxuBp1lLgjl6ZEYAM7sk9N2HfxQzG1m53WgdQmr24HrJ3TUsy+iY8dFCHMtNtNexQx5
         o2St66asSRtQSnXo8S8u0H7RtcHVPUbu9ZOxVnaZg2XU6QLE1zY05Krs60WCv2P23sF0
         agcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSKOZSS+8I69w/h4nXhFaThTeoeMzXOVyQmEyzgYOfe09RvriZa/jRMaRxPS6YeFE/6cHN4P/nruUMMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNmVyDmgBK0e2yWr/j4CogRMl5JMClapFiSt65WvUV72USzQ5I
	RrveH6Vxc3o2Q+3AjCwUEhsN2IYI7r1HzGQkBeuVUnlkHJ+H7LfF0a67JCzKhJ+EDv3mczGWs3y
	f0kdPuFjdB+LJMKmUgrFPD0hBbw0V7Dw=
X-Gm-Gg: ASbGncuQT5ZMyFbRxXRIq/uAXtnfm8f5200VW3A+RRIl4ioDw5LTNXLbOoNf+rdP0z8
	Zpks0u/L/fqDsF61UWG2ElMdOQ2g7W/5KtZ3ZGnCL09M7Qvw5LOr8HT4nRL4tbcLZUd5tKS2Zhn
	8Rtj4Bn8LxAWicwd31CGtaL71vPRn3Sm3QwuPbswo+a3IX
X-Google-Smtp-Source: AGHT+IFYl+Ft0kbG2NiyWrlW2MV6b/ZVFtkAFRZSxwWhddKmAQ1nyJGlhgP5vBH1kUixT8v5vBmcy4TQMoIbgpTDnC8=
X-Received: by 2002:a05:6102:41a7:b0:4e5:992e:e397 with SMTP id
 ada2fe7eead31-4e772a6c096mr6525681137.19.1749295203579; Sat, 07 Jun 2025
 04:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abinash <abinashlalotra@gmail.com>
Date: Sat, 7 Jun 2025 16:49:52 +0530
X-Gm-Features: AX0GCFv4euMr1lG0iH6e_EvZ4yri_2LlzjMTfXyuNO6Jcn67n5Mx5miRqybKsxM
Message-ID: <CAJZ91LC2PXK-F8D7br-JKWiREf0hb2BFbEXvugN+=xzuTPdK5Q@mail.gmail.com>
Subject: kernel BUG in populate_free_space_tre
To: syzbot+36fae25c35159a763a2a@syzkaller.appspotmail.com
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003795ac0636f9872b"

--0000000000003795ac0636f9872b
Content-Type: multipart/alternative; boundary="0000000000003795a90636f98729"

--0000000000003795a90636f98729
Content-Type: text/plain; charset="UTF-8"

#syz test

--0000000000003795a90636f98729
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">#syz test</div>

--0000000000003795a90636f98729--
--0000000000003795ac0636f9872b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-btrfs-remove-ASSERT-in-populate_free_space_tree-for-.patch"
Content-Disposition: attachment; 
	filename="0001-btrfs-remove-ASSERT-in-populate_free_space_tree-for-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mbm55ulw0>
X-Attachment-Id: f_mbm55ulw0

RnJvbSBkMjVkOWZiMDdkM2VhYjk5NDIzNDY2NWViYjBkOThiMjk4YWE1OWM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBhdmluYXNobGFsb3RyYSA8YWJpbmFzaHNpbmdobGFsb3RyYUBn
bWFpbC5jb20+CkRhdGU6IFNhdCwgNyBKdW4gMjAyNSAxNjoxOTo0MSArMDUzMApTdWJqZWN0OiBb
UEFUQ0hdIGJ0cmZzOiByZW1vdmUgQVNTRVJUIGluIHBvcHVsYXRlX2ZyZWVfc3BhY2VfdHJlZSBm
b3IgZW1wdHkKIGV4dGVudCB0cmVlIGJ0cmZzX3NlYXJjaF9zbG90X2Zvcl9yZWFkKCkgcmV0dXJu
cyAxIHdoZW4gbm8gaXRlbXMgYXJlIGZvdW5kCgogYnV0IHBvcHVsYXRlX2ZyZWVfc3BhY2VfdHJl
ZSgpIGhhcyBBU1NFUlQocmV0ID09IDApIHdoaWNoIHBhbmljcyBvbiBlbXB0eQogZXh0ZW50IHRy
ZWVzLiBFbXB0eSBleHRlbnQgdHJlZXMgYXJlIHZhbGlkIChuZXcgYmxvY2sgZ3JvdXBzLCBhZnRl
cgogZGVsZXRpb25zKSBzbyByZW1vdmUgdGhlIGFzc2VydCBhbmQgaGFuZGxlIHJldCA9PSAxIGJ5
IHNraXBwaW5nIHRoZSBzY2FuCiBsb29wLgoKUmVwb3J0ZWQtYnk6IHN5emJvdCszNmZhZTI1YzM1
MTU5YTc2M2EyYUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tClNpZ25lZC1vZmYtYnk6IGF2aW5h
c2hsYWxvdHJhIDxhYmluYXNoc2luZ2hsYWxvdHJhQGdtYWlsLmNvbT4KLS0tCiBmcy9idHJmcy9m
cmVlLXNwYWNlLXRyZWUuYyB8IDYyICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZnMvYnRyZnMvZnJlZS1zcGFjZS10cmVlLmMgYi9mcy9idHJmcy9mcmVlLXNw
YWNlLXRyZWUuYwppbmRleCAwYzU3M2Q0NjYzOWEuLmJlZmZlNTJkZmE1OSAxMDA2NDQKLS0tIGEv
ZnMvYnRyZnMvZnJlZS1zcGFjZS10cmVlLmMKKysrIGIvZnMvYnRyZnMvZnJlZS1zcGFjZS10cmVl
LmMKQEAgLTExMTUsNDMgKzExMTUsNDUgQEAgc3RhdGljIGludCBwb3B1bGF0ZV9mcmVlX3NwYWNl
X3RyZWUoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsCiAJcmV0ID0gYnRyZnNfc2Vh
cmNoX3Nsb3RfZm9yX3JlYWQoZXh0ZW50X3Jvb3QsICZrZXksIHBhdGgsIDEsIDApOwogCWlmIChy
ZXQgPCAwKQogCQlnb3RvIG91dF9sb2NrZWQ7Ci0JQVNTRVJUKHJldCA9PSAwKTsKIAogCXN0YXJ0
ID0gYmxvY2tfZ3JvdXAtPnN0YXJ0OwogCWVuZCA9IGJsb2NrX2dyb3VwLT5zdGFydCArIGJsb2Nr
X2dyb3VwLT5sZW5ndGg7Ci0Jd2hpbGUgKDEpIHsKLQkJYnRyZnNfaXRlbV9rZXlfdG9fY3B1KHBh
dGgtPm5vZGVzWzBdLCAma2V5LCBwYXRoLT5zbG90c1swXSk7Ci0KLQkJaWYgKGtleS50eXBlID09
IEJUUkZTX0VYVEVOVF9JVEVNX0tFWSB8fAotCQkgICAga2V5LnR5cGUgPT0gQlRSRlNfTUVUQURB
VEFfSVRFTV9LRVkpIHsKLQkJCWlmIChrZXkub2JqZWN0aWQgPj0gZW5kKQotCQkJCWJyZWFrOwog
Ci0JCQlpZiAoc3RhcnQgPCBrZXkub2JqZWN0aWQpIHsKLQkJCQlyZXQgPSBfX2FkZF90b19mcmVl
X3NwYWNlX3RyZWUodHJhbnMsCi0JCQkJCQkJICAgICAgIGJsb2NrX2dyb3VwLAotCQkJCQkJCSAg
ICAgICBwYXRoMiwgc3RhcnQsCi0JCQkJCQkJICAgICAgIGtleS5vYmplY3RpZCAtCi0JCQkJCQkJ
ICAgICAgIHN0YXJ0KTsKLQkJCQlpZiAocmV0KQotCQkJCQlnb3RvIG91dF9sb2NrZWQ7CisJaWYg
KHJldCA9PSAwKSB7CisJCXdoaWxlICgxKSB7CisJCQlidHJmc19pdGVtX2tleV90b19jcHUocGF0
aC0+bm9kZXNbMF0sICZrZXksIHBhdGgtPnNsb3RzWzBdKTsKKworCQkJaWYgKGtleS50eXBlID09
IEJUUkZTX0VYVEVOVF9JVEVNX0tFWSB8fAorCQkJICAgIGtleS50eXBlID09IEJUUkZTX01FVEFE
QVRBX0lURU1fS0VZKSB7CisJCQkJaWYgKGtleS5vYmplY3RpZCA+PSBlbmQpCisJCQkJCWJyZWFr
OworCisJCQkJaWYgKHN0YXJ0IDwga2V5Lm9iamVjdGlkKSB7CisJCQkJCXJldCA9IF9fYWRkX3Rv
X2ZyZWVfc3BhY2VfdHJlZSh0cmFucywKKwkJCQkJCQkJICAgICAgIGJsb2NrX2dyb3VwLAorCQkJ
CQkJCQkgICAgICAgcGF0aDIsIHN0YXJ0LAorCQkJCQkJCQkgICAgICAga2V5Lm9iamVjdGlkIC0K
KwkJCQkJCQkJICAgICAgIHN0YXJ0KTsKKwkJCQkJaWYgKHJldCkKKwkJCQkJCWdvdG8gb3V0X2xv
Y2tlZDsKKwkJCQl9CisJCQkJc3RhcnQgPSBrZXkub2JqZWN0aWQ7CisJCQkJaWYgKGtleS50eXBl
ID09IEJUUkZTX01FVEFEQVRBX0lURU1fS0VZKQorCQkJCQlzdGFydCArPSB0cmFucy0+ZnNfaW5m
by0+bm9kZXNpemU7CisJCQkJZWxzZQorCQkJCQlzdGFydCArPSBrZXkub2Zmc2V0OworCQkJfSBl
bHNlIGlmIChrZXkudHlwZSA9PSBCVFJGU19CTE9DS19HUk9VUF9JVEVNX0tFWSkgeworCQkJCWlm
IChrZXkub2JqZWN0aWQgIT0gYmxvY2tfZ3JvdXAtPnN0YXJ0KQorCQkJCQlicmVhazsKIAkJCX0K
LQkJCXN0YXJ0ID0ga2V5Lm9iamVjdGlkOwotCQkJaWYgKGtleS50eXBlID09IEJUUkZTX01FVEFE
QVRBX0lURU1fS0VZKQotCQkJCXN0YXJ0ICs9IHRyYW5zLT5mc19pbmZvLT5ub2Rlc2l6ZTsKLQkJ
CWVsc2UKLQkJCQlzdGFydCArPSBrZXkub2Zmc2V0OwotCQl9IGVsc2UgaWYgKGtleS50eXBlID09
IEJUUkZTX0JMT0NLX0dST1VQX0lURU1fS0VZKSB7Ci0JCQlpZiAoa2V5Lm9iamVjdGlkICE9IGJs
b2NrX2dyb3VwLT5zdGFydCkKKworCQkJcmV0ID0gYnRyZnNfbmV4dF9pdGVtKGV4dGVudF9yb290
LCBwYXRoKTsKKwkJCWlmIChyZXQgPCAwKQorCQkJCWdvdG8gb3V0X2xvY2tlZDsKKwkJCWlmIChy
ZXQpCiAJCQkJYnJlYWs7CiAJCX0KLQotCQlyZXQgPSBidHJmc19uZXh0X2l0ZW0oZXh0ZW50X3Jv
b3QsIHBhdGgpOwotCQlpZiAocmV0IDwgMCkKLQkJCWdvdG8gb3V0X2xvY2tlZDsKLQkJaWYgKHJl
dCkKLQkJCWJyZWFrOwotCX0KKwl9CQogCWlmIChzdGFydCA8IGVuZCkgewogCQlyZXQgPSBfX2Fk
ZF90b19mcmVlX3NwYWNlX3RyZWUodHJhbnMsIGJsb2NrX2dyb3VwLCBwYXRoMiwKIAkJCQkJICAg
ICAgIHN0YXJ0LCBlbmQgLSBzdGFydCk7Ci0tIAoyLjQzLjAKCg==
--0000000000003795ac0636f9872b--

