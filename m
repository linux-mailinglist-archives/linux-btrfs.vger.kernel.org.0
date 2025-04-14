Return-Path: <linux-btrfs+bounces-12995-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AE9A885CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 16:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1479916B3D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1882750EE;
	Mon, 14 Apr 2025 14:40:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from server.interlinx.bc.ca (mail.interlinx.bc.ca [69.165.217.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FF3AD21
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.165.217.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641622; cv=none; b=oZQmUjAOUI3IPMQvuQ6/nJXlnsf6qQICe2SINMGfChUkxw+iYSD3+EPwk01Esv9wSdhGzhbW5ZvPguO2q+XnikDgUde+F0WC7+/li+oZMidR77So2ZuRs1OyT6qi3C1HKuBz/hz6IL0ogotL69GoPowYkydKo544ws2npDtmARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641622; c=relaxed/simple;
	bh=DV5ogOF/iGOE8Se6Z8+cxfCeXfC6BYRKPchDbR1QkgA=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=JM7sBd/d8DV2vUqCkvgYZiGI3o/VDixBShknR8ZUuBsP3YEwuERMHLY10YG3IOFnOOZVxKWdAyo+S7rptTnsplDhWZZwTKlmtqHLLn8OUVTKQc1mO4NdEDtNSp5O3IdWO29Up9fGAzBayUPWB7KIosrdwp0UyluniAb1ufMwUXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=interlinx.bc.ca; spf=fail smtp.mailfrom=interlinx.bc.ca; arc=none smtp.client-ip=69.165.217.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=interlinx.bc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=interlinx.bc.ca
Received: from brian-laptop.interlinx.bc.ca (brian-laptop.interlinx.bc.ca [IPv6:fd31:aeb1:48df:0:2374:a2d1:e1b7:89a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by server.interlinx.bc.ca (Postfix) with ESMTPSA id B4B91302C7
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 10:34:49 -0400 (EDT)
Message-ID: <dea3861ab4b85f2dffc5bbc9864b290f03c430f4.camel@interlinx.bc.ca>
Subject: Odd snapshot subvolume
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-btrfs@vger.kernel.org
Date: Mon, 14 Apr 2025 10:34:49 -0400
Autocrypt: addr=brian@interlinx.bc.ca; prefer-encrypt=mutual;
 keydata=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
 Dc1uQeNIcmTaawmvwmnhoNZYwBfdrEi8mWJtwQ9rxRpbkrz8OFCbNGc1AGeRx464OkJ3EHy+/x0Xn
 9qDxL7OLAZ6tChCcmlhbiBKLiBNdXJyZWxsIDxicmlhbkBpbnRlcmxpbnguYmMuY2E+iHYEMBECAD
 YFAkFRkTovHQBUaGlzIGlzIGFuIG9sZCBrZXkuICBQbGVhc2UgdXNlIDYyRjJCOTcwIG5vdy4ACgk
 QWkUtrHIQJiJp2wCeMuwXHszwNxBY8nR9o9Rv9mrrWjoAn14m48ueXrhGJsJOwj12CqynCKwdmI4E
 U55NCQEEAOhiOhVQNRL+2mctVQUjsOFHftZvNXeNM6w7UC7+zoWFhpuQomK5Wy8E1s1qt68amxbvG
 fJe7BRln3aDaErtxzv1RIJbtxOpcmyk5pg8ofdza9/kBX1PtwhR0RpeFHJ+uE15CcAvzNkOM4snWl
 keneYNASKQ76ih2Q/pep/kdF1BACDCJ25riQE3BCABAgChBQJXsqABmh0CVGhpcyBrZXkgd2FzIGd
 lbmVyYXRlZCBhcyBwYXJ0IG9mIHRoZSBFdmlsMzIgcHJvamVjdC4KSXQgaXMgbm90IG93bmVkIGJ5
 IHRoZSB1c2VyIGRlc2NyaWJlZCBpbiB0aGUgVUlELgpTZWUgaHR0cHM6Ly9ldmlsMzIuY29tL3Jld
 m9rZWQgZm9yIG1vcmUgZGV0YWlscy4ACgkQDpHnaGLyuXADagP+O8Xu3d/cauZx84xmjGxTL7OBMi
 x/4Lr6cUeh5ahcptaJEQHMgYxWg+SbNLq5iXyyUL7zn+FlVT804PHpOvpdd2zETqow4yteuz1Olyv
 04dJWCGaqUY1XpSEyaeFhPZPWQ7libV+vDtb75VNPm88JhsBZXoZ8kSUactp+RqjZDye0KEJyaWFu
 IEouIE11cnJlbGwgPGJyaWFuQGludGVybGlueC5iYy5jYT6IuAQTAQIAIgUCU+BJ4AIbLwYLCQgHA
 wIGFQgCCQoLBBYCAwECHgECF4AACgkQDpHnaGLyuXDzRQQAhiAYEko0qilFSVu9TKEHzUGdSw9jFW
 O4rAlocPSXf0j0e2Uw1z1v4hvqtW3tMRNK7f+eifvvxfRM9SrM0+DuSQA60/kwP6X6NuJ1SQQ//ck
 klmTr1/rJPC+ZnuIbtE01augCZYLw2TQIU4U2cakLUGJqV8SZsNkmNG+c04lLCsCZAaIENOfAUxEE
 AMbyzutLDHcwOMVUvS6GFjPZ2KfgU/I9n1OzT3/O3UX7b6CU4PZ2xo/1C0dVsL2pGZx8Apm+bEMoA
 /eGRWdkC2G26R7rAXnXLPsTaddrAc1j17NVbIWZe1dUP5ju/3coYrrkBgIYRhGom4jxVqiwnEchGp
 GLQWuY3BP1juen3+eTAKD/2AdHKjAWRlOj8fyCow2cHgbe4wP/Q/nnagGdqyMIWIjkAR4/zvWJ28S
 6ERnx4hdvlzvLMeryaSNzEi8/MUfWI+r20G0SSYP6BpOeguneDHHle9v+PPBooE6FcwmMEVBf7wVz
 WUFhAeUYGwbXJw+M7wpWP1v6IPK8JexMnip7Ke6gMO5Xy9ad9kmYN3VrYytG3UHaPyYD/R26wKk+Z
 M2abDpIuqvJR2Blc5QvnM0iCnmZVHonm9Y9AEehZsON2hAt02+y/yzZ98yhCN9AbLFE2Gm/N9Q0M0
 b7FVm7yCpIeTxtn2zrflfof7ln3GaGtbiEASoQpsevlcTppt8NSp49ZRtCKBturoXLXuXn59aNAx3
 1XWCgMHybtChCcmlhbiBKLiBNdXJyZWxsIDxicmlhbkBpbnRlcmxpbnguYmMuY2E+iFMEEBECAAsF
 AjTnwFMECwMBAgASCRCXcRCUYvK5cAdlR1BHAAEBRe8AoMrjwQhhp40fTxJ4jq7usVx6eXjIAKD6s
 xVTia/AeRc6ukrODwvqng9hJLQgQnJpYW4gSi4gTXVycmVsbCA8YnJpYW5Ac3VuLmNvbT6ISQQwEQ
 IACQUCUoKgWQIdIAAKCRCXcRCUYvK5cOwGAKDJO2OHMNaFyC5WbVwpvKp6EkaYEwCg9ETMisiO9K5
 KevxXj1exCPMvylm0I0JyaWFuIEouIE11cnJlbGwgPGJyaWFuQGJlb25peC5jb20+iEkEMBECAAkF
 AlKCoFkCHSAACgkQl3EQlGLyuXBgpwCfRHsJWNscLl9DaVKVI83VN0hUvXYAoLzLmbZ4IPIcKGtQX
 ipcK+XgYQfctChCcmlhbiBKLiBNdXJyZWxsIDxCcmlhbi5NdXJyZWxsQFN1bi5DT00+iEkEMBECAA
 kFAlKCoFkCHSAACgkQl3EQlGLyuXCxygCg10BJ1RJ0B8MLJqaEPwjImxO6Xj0AoMQsthNoXCwy7XO
 hUiUt+XjGDKKGtClCcmlhbiBKLiBNdXJyZWxsIDxicmlhbkBicmlhbi5tdXJyZWxsLmNhPohfBBMR
 AgAXBQI8t9eKBQsHCgMEAxUDAgMWAgECF4AAEgkQl3EQlGLyuXAHZUdQRwABAQbaAKCwKGGFFlRor
 ED/FnKXTHtor2eWtACeN2TsVMsCPshjtaVuLs+fH5LO6P20KUJyaWFuIEouIE11cnJlbGwgPGNvb2
 tlckBpbnRlcmxpbnguYmMuY2E+iGQEExECABwFAj5dJ68CGwMECwcDAgMVAgMDFgIBAh4BAheAABI
 JEJdxEJRi8rlwB2VHUEcAAQFC6gCg1K4t13XDc52IO3uIR1aVM8MqPgcAoIIIILSGhMFEaLY34bSo
 cNNYtJ79tCxCcmlhbiBKLiBNdXJyZWxsIDxuZXRmaWx0ZXJAaW50ZXJsaW54LmJjLmNhPohkBBMRA
 gAcBQI9yTdUAhsDBAsHAwIDFQIDAxYCAQIeAQIXgAASCRCXcRCUYvK5cAdlR1BHAAEB1zwAn0iSmK
 YuPu2zv6B2hiJtKnGJsVLeAJ96FtWl9Uo92jc1RMRHFxFLvTdI4LQyQnJpYW4gSi4gTXVycmVsbCA
 oS0xVRyBhY2NvdW50KSA8YnJpYW5Aa2x1Zy5vbi5jYT6IZAQTEQIAHAUCPcUi2gIbAwQLBwMCAxUC
 AwMWAgECHgECF4AAEgkQl3EQlGLyuXAHZUdQRwABARkxAJ4+2OV7b7jfDAbQ8L4bhIPJVREXhACg1
 QL4VtqlUUwJ7PLEVZ6V7wll2am0NUJyaWFuIEouIE11cnJlbGwgKD5jbGlja2V0eSBjbGljazwpID
 xib2ZoQGtsdWcub24uY2E+iGQEExECABwFAj3FIwoCGwMECwcDAgMVAgMDFgIBAh4BAheAABIJEJd
 xEJRi8rlwB2VHUEcAAQFrGgCfdZWKmCszRrsU+8mBYDli97WVYecAoLegVz3WuxWsxBVpnWUN+vPQ
 Cs24tDdCcmlhbiBKLiBNdXJyZWxsICg+Y2xpY2tldHkgY2xpY2s8KSA8Ym9maEBraW5nc3Rvbi5uZ
 XQ+iF8EExECABcFAjy1qR4FCwcKAwQDFQMCAxYCAQIXgAASCRCXcRCUYvK5cAdlR1BHAAEBLyUAn1
 E7eftZqeduGBJ33sfO6hW8Xc48AKDHF83gZHpjZoUb/E9Imh4NPkXvx7Q4QnJpYW4gSi4gTXVycmV
 sbCAoV2hhbWNsb3VkLCBJbmMuKSA8YnJpYW5Ad2hhbWNsb3VkLmNvbT6IYgQTEQIAIgUCTWP03AIb
 AwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQl3EQlGLyuXDOMwCfVNMqn4k02agHN6W/ZclR+
 e8S9FkAmwZLhPqFa/X2M7xmW5R/bTMznMmltEJCcmlhbiBKLiBNdXJyZWxsIChDbHVzdGVyIEZpbG
 VzeXN0ZW1zLCBJbmMuKSA8YnJpYW5AY2x1c3RlcmZzLmNvbT6ISQQwEQIACQUCUoKgWAIdIAAKCRC
 XcRCUYvK5cFJJAJ9otGn0eLsltoMCBKFlyK6v4pJDXQCg1cFhVOBfAxeLNHdcZdkdQe+xKxy0TkJy
 aWFuIEouIE11cnJlbGwgKEkgZG9uJ3QgdXN1YWxseSByZWFkIHRoaXMgYWNjb3VudCkgPGJyaWFua
 m11cnJlbGxAZ21haWwuY29tPohgBBMRAgAgBQJLzKsDAhsDBgsJCAcDAgQVAggDBBYCAwECHgECF4
 AACgkQl3EQlGLyuXCP+QCfbEHvWzrLhaJ8noFNlPJi9F3o9S0AoPn+fZ/a/qkAoPt+Rfm7sTUWu/R
 jtE5CcmlhbiBKLiBNdXJyZWxsIChKYWJiZXIgYWNjb3VudCBvbiB0aGUgS0xVRyBzZXJ2ZXIpIDxi
 cmlhbkBqYWJiZXIua2x1Zy5vbi5jYT6IZgQTEQIAHgUCPvoDQQIbAwYLCQgHAwIDFQIDAxYCAQIeA
 QIXgAASCRCXcRCUYvK5cAdlR1BHAAEBVjEAn3Rcfi8zD+Lyad+pLPZ1O+WW0vvGAKDe6fDd4LxROz
 yTgyr7+EcxAU/z8bRRQnJpYW4gSi4gTXVycmVsbCAoTXkgU291cmNlRm9yZ2UgYWNjb3VudCkgPGJ
 yaWFuX2pfbXVycmVsbEB1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+iF8EExECABcFAjys16sFCwcKAwQD
 FQMCAxYCAQIXgAASCRCXcRCUYvK5cAdlR1BHAAEBD3oAoMJDSIFPzWsRv3W2RNdxBqfbMxHaAJ45G
 MtFqAjf4R0lVueUBW1OrUPz2LRbQnJpYW4gSi4gTXVycmVsbCAoVmlhIFlhaG9vISwgdXNlIGFzIG
 EgbGFzdCByZXNvcnQgdG8gcmVhY2ggbWUpIDxicmlhbl9qX211cnJlbGxAeWFob28uY29tPohfBBM
 RAgAXBQI8jisYBQsHCgMEAxUDAgMWAgECF4AAEgkQl3EQlGLyuXAHZUdQRwABASQYAKCC0c9ICbiw
 NqDcob3h63nyueajbgCfdwBSiG5eeRAx9UBgPvPtwOhppCq0LEJyaWFuIEouIE11cnJlbGwgPGJya
 WFuX2pfbXVycmVsbEBjb2dlY28uY2E+iGEEExECACEFAleaVzcCGwMFCwkIBwIGFQgJCgsCBBYCAw
 ECHgECF4AACgkQl3EQlGLyuXCtdwCdG850C123WLJQvNaq+kJbgXebm6gAnAqjBxoorSW5fssdU36
 ALpu5mnmE
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On my Fedora system I have the following:

$ sudo btrfs subvolume show /
fedora_root
	Name: 			fedora_root
	UUID: 			c08a988c-ddd5-164e-b01e-51ac26bf018b
	Parent UUID: 		-
	Received UUID: 		-
	Creation time: 		2021-08-10 18:30:03 -0400
	Subvolume ID: 		258
	Generation: 		5029586
	Gen at creation: 	10
	Parent ID: 		5
	Top level ID: 		5
	Flags: 			-
	Send transid: 		0
	Send time: 		2021-08-10 18:30:03 -0400
	Receive transid: 	0
	Receive time: 		-
	Snapshot(s):
				fedora_root/previous-releases/f38_root
				fedora_root/previous-releases/f39_root
				fedora_root/previous-releases/f40_root.old
				fedora_root/previous-releases/f41_root
				previous-releases/f33_root
	Quota group:		n/a

All of the fedora_root/previous_releases/* snapshot subvolumes make
sense to me.  There are all accessible at:

$ ls -l /previous-releases/
total 0
dr-xr-xr-x. 1 root root 378 May 31  2023 f38_root
drwxr-xr-x. 1 root root 194 May 31  2023 f38_var
dr-xr-xr-x. 1 root root 378 Nov 11  2023 f39_root
drwxr-xr-x. 1 root root 194 Apr  1  2024 f39_var
dr-xr-xr-x. 1 root root 362 Jun 15  2024 f40_root.old
drwxr-xr-x. 1 root root 194 May 15  2024 f40_var.old
dr-xr-xr-x. 1 root root 362 Jun 15  2024 f41_root
drwxr-xr-x. 1 root root 194 May 15  2024 f41_var

But then there is that odd-duck snapshot "previous-releases/f33_root"
not under "fedora_root" and not showing under /previous-releases in the
filesystem's namespace.

How can I access that "previous-releases/f33_root" snapshot or even
just remove it?

Cheers,
b.


