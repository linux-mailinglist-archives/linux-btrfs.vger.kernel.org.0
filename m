Return-Path: <linux-btrfs+bounces-18361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7C8C0C2FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 08:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B1D44F11E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 07:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A082E36F8;
	Mon, 27 Oct 2025 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OZurwgTb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609E2E4258;
	Mon, 27 Oct 2025 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761551411; cv=none; b=VKNrHjCOR1DU/QOh/8zWT3WTDrip9OAQBhPu7L29lKWtvtAsXdV+fTLlhHtFLTgZbnhF6kGhl/NEpB44IiD8XKALY6FAJUzymYAXxqSbSrrlgfXTbF77PsqaEMsKyR4pGtSv9lL7tnXEgSwh+bBcYMMYnxz4GowqeuQiwSnzSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761551411; c=relaxed/simple;
	bh=G4G7Whh4vyN0v4lSi1BE4EWlB0FuPxffZPcWd0NL6Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AM8t6O/U4dQijq3YBPsWuuGm3r0/WoqQwaTx6z6cAfNTlpyRe8K4OBtHzJxpgNfgPp4/HyVEjjmNz5eclA/ZJWG77gh1IJeROX8sOZtLlWLqgZEh+XYhRKsjetcV9tbWl6C4K8dE2fkfp99+cr/EJGUwIlsvLjxWxD4+4vEypEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OZurwgTb; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1761551406; x=1762156206; i=quwenruo.btrfs@gmx.com;
	bh=HNmQSlGV6BRyCGWeZ/7OIYXUKDtG97C5LjkkMaCV820=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OZurwgTbxvoGEJeLFFd3HkXiDppgkvpwbUNnel0tCBQJaWT1p5cdj9VIXjXmJpRO
	 S5wHfF73kTNZDOsqxnsai1zgrsZeTJO5+tnhecpg0GitkZUx2m11r2Ne251cKtdC6
	 D9XL/D/zIb0I69bppvLabJg5B4MBZnPQ9hG/TaduMV3MFmgGZTPnJNa2S64EFRANW
	 jPxT+rKnxrs6yT90Fkw+CiA7G9bcTuz2ZaPQ3lSPZyl/fm1zDi1MwTePc6/u7HXeb
	 gAkzVDn67vkc0Wg3APec9l5byIxYo8G30GBHknSGrFBeYUNT6Aph+NytRQxTpqBlc
	 XLkUoroM3EO43KgKwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma20q-1uhRG51pqO-00Krbx; Mon, 27
 Oct 2025 08:50:06 +0100
Message-ID: <2adac975-01f1-4640-a073-715c804987d6@gmx.com>
Date: Mon, 27 Oct 2025 18:19:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [btrfs] b7fdfd29a1: postmark.transactions 9.5%
 regression
To: kernel test robot <oliver.sang@intel.com>, Qu Wenruo <wqu@suse.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 David Sterba <dsterba@suse.com>, HAN Yuwei <hrx@bupt.moe>,
 linux-btrfs@vger.kernel.org
References: <202510271449.efa21738-lkp@intel.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <202510271449.efa21738-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ay2hWRWhxNtz1Qe/0cjPp2kjf7XBiVGk9UlRUbqJiioYPNAkFVW
 7awNrvbprh3UlqceD0UOSuSIz6Ak5PLbOVMrEIHWQup3UWKDbmdcXs6XU9fPY2jOCCNYxVx
 Lnmw+y1asxsv2PKEraPBZVVpdG8FILL1n//n38d6jBqA/gZKsuS7RFQw81JaINOSEuDjBMg
 JSVBCYb6oDpHpAI0Zd/Lg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YS5KIDk/RkY=;xnmSZgAzRpLJWJgWfSFPzc/pOT/
 ZfTGRT8t9AdRuJXd/BSwNqLXoNkrXWfGF88B6Ga2X5NSCO1qqv4r3xflpo5oG7/aX9UzYTilK
 2VsU+Nu4evSQLW31QwsSEpo9UNSrKYDRx7TEaCh6l/rFcLaxxbuzx0YzF5jfb+ly1+CwfVFjg
 O/gdcWYGP8oP5F/nU1nEiq+5JPA474CJfd/iVMkyVDMBQLbsHb+ZjHeTDhDxU5PTetWlaJes8
 vZpTVOye4NXvJXA5YxTpvRn9PPnDF85fruCJvrGWk2atPAw789UJ4+N0zJfjnAYLCGJ4cQ9Nu
 JyEZEG4/IbkA4Mzs0XMNnmN7rG4hCooyN/x6/RxfH1h9DEFfu6S/2EaJv1T7JjQh8sP2FfMop
 50F2mulxGqgPdZd2YU89t30PM9zf6Qbn9474IdiVvxPvKYoleCMfQNPnJMYYh6H4X3JWFw4rH
 JyVKWmlGd3w03r8kW9y0/bipMPMKPyzDO213oeYGqtPQ3Kne0Lw5rovJ+Urqt4h3Y7l5C7x4w
 zLNyUgxpc6yx95HgcN/7H/WPP1JoBSVypsPq+Bp+GlSNz2abdxGTCG2vKR2Os5tJIg2bkvfLb
 1YztmGILZi51HH68bELXbH1UDBvAn+pO6U/mGY+f6Lm3T0vCXffBCpy8+4PEQcnbcXbVKI8ud
 N4l4BCmKoJV30XPCM5aTiuOlGAOnWfc/Nxd6t35COvEMzD4DcVRvstSz6irqcD77s+LEfP5Aa
 QPW2Nh76Udbmy8NMwdLw6StYddEVldQYNEjkMdwtrTojRviiyeAg3j9eHdAI6Tjuh1TWSrcLt
 iNnQ7iLU1P1eO0zNuAtsUrJUhHJg0cmSMWDw2dd1lW6jZFQ1xFnOBP5dMc5rz5wvuixq/J4bx
 LKjDmlPQkRwqXr+pUvnrQyQlWs/CQKFUw71fgmfqmIUrzBbfsEjGI0M2BXP+emQSKtOhTwNbK
 uJtbnFVmuwlSACt+1cjrE3XP4GKDhM0ssUKKfjfDh14y7suIFac2G0rb/9CNYGdnOWvaw41RN
 9WA9yNi8s8jRDAJOwuxSe0sVENCKyGbO6Fwsis7kJHZ41aDPOShA8ttLS55YEJ3yFqEX+mEa4
 Tn5e91Nii7NEUmAOdKNe2UoGs2v98n6LmDGnM3gpOFXIghpgFDMST8dPUeONI3nCMKI0RHZHE
 ERcziFu0YhpMMX125ScN+YB1gpWzz8cxtScQDYn1gnFkV8J9LakPpiutqp/tXF3xOG3bVqNGL
 46ICXP2abdEVYBOdZCoIjTilnm3GhtpRqeX/2XMNwuzvZ9ER6StqEc0Bhg3dA24SI+onzPXTv
 0fBOUqhfLB4K8wBaYqOjsWbqJWImbONJy0kOOKFtCHrQTtvaa9k6VplTH0U9Dj5mVbyhYGr/F
 GB0OK9Vn3FglMsRYYGc0FHQ9z4GqCa7IMzv6XnDQxy988/AAk3+fN7vfEqQ/mFjPyQzfb0d5V
 Y0B31xHOWo4rJvUrFmi7PgqUK/CnknK9WSJavED8DlZrxuBTxjQeQVnKPaD5E4M7/jrjhz+TH
 9pRiqS15ZDx1OkzvBaU0/n97TZyrrzj6yhu6lVv+vI3xfICTU/Ks32odNnduTHwVDcu/naBsz
 afP0zPh65nxoEllwwuGD/kMarWz0LWjbvjUTYf9iClK6tpx+CoxDTmQpRexoLvv3YTm0lxj9y
 Ai+dHwIRoBtmOoIP/PmH1gePQEvREn4psU915QP50qUoFjVyxwlTJwP/DRdy46KaAFHvAh3wv
 VUhxqTn5aQEYhJpKBenz12qauq/IKnLK1Q/3mYWWFME/7OrYNXqpV+xBu9JMpTt+SR4MBQuxw
 e1Oy9jlpLT8W+l7D6++/WXJfMV1kxCQNlsIEWWlSBrLXaG2dydogYy8zxNhZL3+3XIps1kWGF
 Ibo7cULYhVMH84GHVjDBH63RoBoBiTfR+wHIKgfuPyml/gx3UBJPQx67+3ddlCy34+Q1+yQUD
 bBXGiSOZOt2cqFcVnIF/wCnTCcqM6c79SXLigJsWMzSanrd7Tlg6ZgtukClg3zcuEUCpFqF8n
 AcFXyoc9faUj+OB9y3JaIybMvymSkp7LREK9tuGbK5Hisl8zJWgyT0hDnkNplSNkF77P3zpoT
 orMv9rf8tVuzHJPO4Actwz17JDOLmByzbP8ExuTmgOPPxEKt8ys/vyIyJRZ70IRLfo4hl7cnl
 QRo1fVBl8yODl25kSFQC9cvav2hK2zC6fFxYfHPc6ZdXLWPh3w4hEYd+8C3Nmu3K4d3QnTsEm
 r08hJHTvwPFWlYlIAGB/1fSI0C3aBIOo1RcReWSIIGbhWPdIfvSz26rstJVRZBu2sBQTVPMru
 UDSI3t0v1fwuG/VE8MOYQJXIsKR03+1G/ZvuOk/tVlMurFeMRucYOAScvwFdDAnu1xU8+Z88S
 YjJrcH3oRNi7D4YPJ6G2zASGvy4XGhztPotzxst4TOYB3f6Up2am5y+ukWt12P8w/MuSN5HJU
 2i//MWScGl3YJk4lR+EthHzKsgZxcCxI3ymuSUwbNj4PjXER3YuJFC6HH0hJzWfC40XItenql
 Eau7JPX8HZKVzavIlKUC6Q12tSZ+Ah3N9CXMrqiR/iRn3qabTJ0JW0mqtbDEKyYfdY6o54qhG
 kSMJbag5l3JVHQXnwanMP2Mfpku1mHQ/eurtUXc7nXnkp5cRqwIw7DeelnjP+EaqirFX6Tty9
 oxbjE/caKQscS5rrrrLWhA6l5ngL2CgNVfXbXXJuQnoUcU6C8eU/60/8cx6FU4nOS0cE9N5FJ
 SlGQG7ZISdK9kQWltUjMgKZeKPgloG3yFz1LKNGPRuDrsmQyhhwy067r7s5+2GbvmTD5CqU41
 dzj2QO/7MFtccgpGr3uB7ouu2acM4PMvMZYyjlEdUT+HmLsi5dZ6OE2Xbu4Y2eP8my7KiBiOT
 gvG8aDcQf49I3jAq9qm5Wc30BF9arDuFfQfsLS+zm6/F5HCb0JRNllTfBxoGegHxw954h1VzX
 T1vdGqjQKvHslQoqEnO54AhXWC3wQE6BqC88kwP5e/+ejuRfqGK2pVFMcr+Axey7NlFOS7mhE
 inW9kSzkjzm8p5sxmqW3RsJIfUnyEqcQUnI3tyYpF5ZzmD3PRX4PeUgSxqw3FrvMlP+hOBr4+
 JVO/ERR7qohh3b8HkI+Ms/RdBKN+e2tQSkScWicoCebuNTFNdC47yS1KffN3YSh8mwD6hwSQ3
 N7FQdahv7LFtp0tAVG75OsPWP99ts+IOkySNR/lJFm+wQaXFLw/wbRX+azRp04PqlJYgu7P7q
 Qq/7xiTFYDrqQ5IPzz0ACY6EEYPB+TDR7lKVKsTTuP4hv4Q1kdAdt4A/25wnj6oc9fQlgaIsc
 Z7Y5uMSf3x0El+k/TOXlP8ctejSWpQ3cBCiYpWjdgt+itwl4BBjttiV+UoSdta7AC64lXfbC6
 dss4rfi//dU8eWT5eM5e/0TH+u+GBdc14h2gwWqOlruxojLEePVXA/gjnoVa5P6LN2uvaWvq9
 e7al3GVx4q6zHO2Uc7yDYn24MG88kGT9X/mJ+xj1xkrZFFHrbimHGi23syj3tKXp+OD2sG0o2
 YxRhYc8Rv2sAGfuaN6RNUqWTYuCcA6RhJPXYPZk7lIivWjvE3g5Z4oPLNmyiTDAPSQe6ohDMB
 O5aXiGsn6CohWZXsGvYnqVo3m1QflPBCUAAk7mP19t3oIc9vEgNVhqFjqOj6r2cwBDGLpZz25
 arSBo/mZWO2g5aH1RxuDwgnjNyAurNHloPFLjjdp+M91ZiwR0oUB15GL7yq5VPOPPoqdQGWwZ
 /Ek2pcP853UBy+FL9sNPOKhzi8rfOowZgqfs19lIL+TDqL1fzuEBybYKsmrfxpiNOhDH5qRpF
 zTI+iEJQtImnOLjDT4nAW2KCYBFipcHBh2W3K5dAsTfN+0HkseZ4mOcQ2/6cj2bkfc9RB1zhc
 wmGhcq145e7s/KosutZ5QhuGM63JTfIpL8rfBTte+g9aIrgwBv83TD1dQwhb6b4aVX4jqbq6y
 BoaM/H+nqdXuufylvZX+oVkHbljhyJ/xI16JG6RRH77mPYLoX0hBbfMX80/MuIhikDOvHLg0I
 PvkjMnawDcQdSPYgXyKFiU9kZI8Dsko6TAtQQ2lE2vvw9R24PJ6wOhhjgD6q+nnMuYsflcg6g
 j1aW3SbkyzN1Q9gRyA2Hp9d6LZJim9DW64leLIy+f2xgN5KCg6gVVCWsZpJwZfhHcSeup2lxs
 mGgWsLhHzwXrWfWQXX+L0TUVxooi3grUT71kyJBlINuGSxxp57AQmNK4CmAaCCUQfAtd2hYQm
 QwYQOaE/e/1YyWSku/KdspEaQjGlGLIHCJfoa4xgeSzZRUlJpojlGBGKD8Pwp7xzSlfQM7hI5
 mDNbBkJuvqLUiGMfuRrNYTi96QthDVszVQZwl90c3B755IX7EbatEju5weS6d4pMqpx0OnpU/
 uHspiFzifd3UJ864vB/njJ4OgJ6T1O/FmQpK6si3/h40p9RpSmhgeIl8S3H944ZB0MAegZVuv
 AOYDJfVozWjZ5VEOYyF3GLQZlXfhJlLecLMqqWw71hB7UPY1V05efEcrZZ+11uOODF6KyeIst
 GpNRVFxh79AlQMOtdLLEsHNGfCdMbnmENavRVSj88ZgKquDvCLRdOyN0EEpNpilCBOSx3uGU1
 Op6d4AntMqLhbnk+80t2faOnvVfupyyjnKPUM4LyVQxZ7jkCoqSkeliHs/OFDRARtmqXtUGZ0
 sY7j9n61Vt2CPilvjCjtRe/CeKQBJPXF+O/nHV1KYNbQZlr3xYPf3L9klFU+Tnb4o1BCTZUjR
 K3IiojoRaBxY2/oGHFoLBknruXupOFwSZDO8AILECO+l9wBE3eYeE5np1YrvI+tsD6fVkYMJT
 MwCimaGW872XN/zdOe6l///15oNMxRI7eE6j2nmJpePv2bmfEoqFrz9iF/CS58UQDwnHxL5nb
 7Rzur2WPCD2gwZQWe/K9PNTrGSOzogudpdAahnaF8eE38hpE09qhOxQlcdvQcdEpbMI9v1MUu
 mpLWhmkZdjcUHpLaiuH3TZYvxapyZVAV9mcIdELV459G9zQExF1+ea1OygclHiVAkPha70sfv
 o0C+emnWYUjsK5ejpDLTx63mW7bRQn/tfgsX4VoLf29PU3f



=E5=9C=A8 2025/10/27 18:11, kernel test robot =E5=86=99=E9=81=93:
>=20
>=20
> Hello,
>=20
> kernel test robot noticed a 9.5% regression of postmark.transactions on:
>=20
>=20
> commit: b7fdfd29a136a17c5c8ad9e9bbf89c48919c3d19 ("btrfs: only set the d=
evice specific options after devices are opened")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
>=20
> we are in fact not sure what's the connection between this change and th=
e
> postmark.transactions performance. still report out due to below checks.
>=20
> [still regression on      linus/master 4bb1f7e19c4a1d6eeb52b80acff5ac63e=
dd1b91d]
> [regression chould be solved by reverting this commit on linus/master he=
ad]
> [still regression on linux-next/master 72fb0170ef1f45addf726319c52a0562b=
6913707]
>=20
> testcase: postmark
> config: x86_64-rhel-9.4
> compiler: gcc-14
> test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU =
@ 2.90GHz (Cooper Lake) with 192G memory
> parameters:
>=20
> 	disk: 1HDD
> 	fs: btrfs
> 	fs1: nfsv4
> 	number: 4000n
> 	trans: 10000s
> 	subdirs: 100d
> 	cpufreq_governor: performance
>=20
>=20
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202510271449.efa21738-lkp@intel=
.com
>=20
>=20
> Details are as below:
> ------------------------------------------------------------------------=
=2D------------------------->
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251027/202510271449.efa21738-l=
kp@intel.com
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/disk/fs1/fs/kconfig/number/rootfs/subdirs/tbox=
_group/testcase/trans:
>    gcc-14/performance/1HDD/nfsv4/btrfs/x86_64-rhel-9.4/4000n/debian-13-x=
86_64-20250902.cgz/100d/lkp-cpl-4sp2/postmark/10000s
>=20
> commit:
>    53a4acbfc1 ("btrfs: fix memory leak on duplicated memory in the qgrou=
p assign ioctl")

This is definitely not related.

>    b7fdfd29a1 ("btrfs: only set the device specific options after device=
s are opened")

But this may affect performance, because without this fix, btrfs always=20
falls back to `ssd` mount option

Now it will properly detect rotating devices, and won't set `ssd` mount=20
option by default.

But if this is causing performance drop, we should really consider if=20
`ssd` should be the only mode we support.

Thanks,
Qu

>=20
> 53a4acbfc1de85fa b7fdfd29a136a17c5c8ad9e9bbf
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>        2010           +10.5%       2222        nfsstat.Client.nfs.v4.ope=
n_noat
>       97983 =C2=B1 11%     +18.5%     116101        numa-numastat.node1.=
other_node
>       97983 =C2=B1 11%     +18.5%     116101        numa-vmstat.node1.nu=
ma_other
>       16001 =C2=B1  5%      -7.5%      14797 =C2=B1  5%  sched_debug.cfs=
_rq:/.load.avg
>     1474354 =C2=B1  3%      +9.9%    1620281 =C2=B1  4%  sched_debug.cpu=
.avg_idle.avg
>      756151 =C2=B1  3%     +10.0%     831539 =C2=B1  4%  sched_debug.cpu=
.max_idle_balance_cost.avg
>        3585            -2.6%       3490        perf-stat.i.context-switc=
hes
>        6141 =C2=B1  2%      +4.0%       6385        perf-stat.i.cycles-b=
etween-cache-misses
>        5796 =C2=B1  2%      +3.9%       6024        perf-stat.overall.cy=
cles-between-cache-misses
>        3580            -2.6%       3486        perf-stat.ps.context-swit=
ches
>   9.548e+11            +7.3%  1.025e+12        perf-stat.total.instructi=
ons
>      136494            +4.3%     142419        proc-vmstat.nr_inactive_f=
ile
>      136494            +4.3%     142419        proc-vmstat.nr_zone_inact=
ive_file
>     2784208            +4.8%    2917180        proc-vmstat.numa_hit
>     2435763            +5.5%    2568673        proc-vmstat.numa_local
>     3042276            +5.1%    3196281        proc-vmstat.pgalloc_norma=
l
>     2627503            +6.9%    2808220        proc-vmstat.pgfault
>     2754381            +5.4%    2903034        proc-vmstat.pgfree
>       97857            +6.3%     104058        proc-vmstat.pgreuse
>        9.80            -9.4%       8.88        postmark.creation_mixed_t=
rans
>      112312            -7.0%     104473        postmark.data_read
>      203502            -7.0%     189298        postmark.data_written
>        9.80            -9.4%       8.88        postmark.deletion_mixed_t=
rans
>        9.73            -9.5%       8.80        postmark.files_appended
>       12.59            -7.0%      11.70        postmark.files_created
>       12.59            -7.0%      11.70        postmark.files_deleted
>        9.87            -9.5%       8.93        postmark.files_read
>      715.35            +7.5%     768.93        postmark.time.elapsed_tim=
e
>      715.35            +7.5%     768.93        postmark.time.elapsed_tim=
e.max
>       51508            -1.6%      50690        postmark.time.voluntary_c=
ontext_switches
>       19.61            -9.5%      17.75        postmark.transactions
>=20
>=20
>=20
>=20
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are pro=
vided
> for informational purposes only. Any difference in system hardware or so=
ftware
> design or configuration may affect actual performance.
>=20
>=20


