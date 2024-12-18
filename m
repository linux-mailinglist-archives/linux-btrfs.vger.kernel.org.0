Return-Path: <linux-btrfs+bounces-10525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8237E9F5E62
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 06:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E8616D39A
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 05:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACCC15530B;
	Wed, 18 Dec 2024 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nFDuGg5C";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G8T0TGwd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D9613F42A
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 05:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734501194; cv=fail; b=D/KSEeC2rKdmk5PmMN7VPpzDWOOS7+K4eaXCdwD/N6OKkZIR0YAaK8JQh/euIoPjWNdBIvHtp1U9c3La+DENVKrfB+Ij4mjAd6NMIiz2B8tUnJXj1dTZDC8WXp7k2UvFa1RV8IiZajEJ4metGrOxap3i+19ldpayhLn4g03fDA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734501194; c=relaxed/simple;
	bh=Dml9Uxomh2vSn9an/58Y16S1/ouZ566+NGhJblEjzck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kKd8svavbdT8x0uBtOdL5xsu9kXYGvpEkmpJVgLbtHP4b7dl4I5X5XdqvV4XcZbU9MFH2OH1pux5o4Yv2E+c8Sr5gQs/6yji3UuWzuUP1XsD25ivUNS0sld2UQreGOZO49cKaXzkM5hlfsVbX9SHWsys6ECoFVmtcKDigJigDrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nFDuGg5C; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=G8T0TGwd; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734501192; x=1766037192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Dml9Uxomh2vSn9an/58Y16S1/ouZ566+NGhJblEjzck=;
  b=nFDuGg5CcbH7f+sMDa1pv7BESrVVdH/9XjCrKqevlcdk7835b9wPT2xB
   9QeROhSTgfli8deMV+0JdMEeQOyaToRHJCzNGbkyqBdaCC4++BC/gXORH
   Mlu1PcyMdK9lq93k6pI4laqPW1TkSkm7W8o3nrBhd/IHl2Q0fhqUjC/XX
   mYC/cCb0PmxzRnEd2awM26A8+10tLGq0s9ZEYNhSpTV2eJUzVtAk5WqD1
   dqizJFUWO4ETS65VaUYhK1rO7uq+SrWa+ySpJxQm/Hm2JtIzmMQ31JC6v
   sd/Aq4blx1hYO3kexYlQyljJuaKfRdDHemHq5XfZUKVBjgsx43XGv/hW/
   w==;
X-CSE-ConnectionGUID: w9mQVzUzQxaiXgV3aUAG/w==
X-CSE-MsgGUID: wJcKWalqRpe9bOnFatSJ7A==
X-IronPort-AV: E=Sophos;i="6.12,243,1728921600"; 
   d="scan'208";a="34145399"
Received: from mail-centralusazlp17010000.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.0])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2024 13:53:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMRhWuPgm5HQ0aFJAA/t3dljt7O8wiXnMr2HUC2aXe4AI3n49C5bvNMLyYoCu8pvSe/InWbtJioXR87NeGITrF1XRF2oyvATQxPZMxIb/KVUvNejnicF6anw8+A6UK1EJVcd64aAkGD5X9jIXgQgXmdWIP2Obeks54z3TjfFwX5AbhMjjztdaof51yRd+Uj8biqkRXV4sStOJkfMq4rGglwncyEG9QY2CWPLNLGX7bJwKf7IrWKZx2DVCaPFZiEKxxUKj46L+17+3rXV5vxjk1B1VNPtXdMXtteFei2BydZe1wC7QLbTPlZKf7Mj6q48puw4IwFrg0cPrBvzZgCHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJVzpshRAKfd8lZplBOGY4qBQdkg/1QDUEKItLOrPeM=;
 b=OYuPZR/CJrA8WMaelUXL4ccAoI+buF1J6TFhnRLNK9LwSHBh30ClstK6SjN+y/MB9aSo2ZmCvWwtSeHACj3uNdmwIIoavOPsuWKeFYD27Q+qJKAp2n6kQk0EmbtYI6yNuykbYnzWmAQlS/C513bt5myQr3LQhvn1PSnX583JrfS0NOjlWbSkbqOL1o4JifiHbBpECSa+gRnymM+wGFT1VuxzPoPNuvCGX/nI06mfyUWX8Rjz0P9f4GQTFeejgEOwOwQN3lVf1q08fATBGwU8xUV1WWSuEPG5nc48aWL1nrytjNXBKBkm2wTvHvNhXXZoPeaCF6RqeBJc5RIJ/XmmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJVzpshRAKfd8lZplBOGY4qBQdkg/1QDUEKItLOrPeM=;
 b=G8T0TGwd+wI/ecnlWyyQwYrwbz07fnP6DyoUqXDBh7tc46lBaXw2YUYc/ZF4oQ6gDRGjwX+sGNkAKL7hZmLPE+KJD1bF9iCIAMp8OeT+nR5BDrItoMfTcVngaOrS/k7NyhFBOe5YVRm4MyC7BG/+IqMiH+akRkYFlZbUCEBeRYg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH4PR04MB9264.namprd04.prod.outlook.com (2603:10b6:610:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 05:53:04 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 05:53:04 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Anand Jain <anand.jain@oracle.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"dsterba@suse.com" <dsterba@suse.com>, WenRuo Qu <wqu@suse.com>,
	"hrx@bupt.moe" <hrx@bupt.moe>, "waxhead@dirtcellar.net"
	<waxhead@dirtcellar.net>
Subject: Re: [PATCH v4 5/9] btrfs: introduce RAID1 round-robin read balancing
Thread-Topic: [PATCH v4 5/9] btrfs: introduce RAID1 round-robin read balancing
Thread-Index: AQHbT+cezdz043QGeEmUwoKxHFpyEbLrgmWA
Date: Wed, 18 Dec 2024 05:53:04 +0000
Message-ID: <amkllcfcvkuebolcjm772phammyqepfmb3agojgvfco7hznlhy@mmssvxw4yr5f>
References: <cover.1734370092.git.anand.jain@oracle.com>
 <90934f391bc1c9772f9e3a7902cf9d04f3b0d14a.1734370092.git.anand.jain@oracle.com>
In-Reply-To:
 <90934f391bc1c9772f9e3a7902cf9d04f3b0d14a.1734370092.git.anand.jain@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH4PR04MB9264:EE_
x-ms-office365-filtering-correlation-id: 5d0987fa-cd21-4c68-8c3b-08dd1f283d71
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YReWFilDvRapjWdu2pZGpsC/NuKdrEROUSsZfasZ0GgVAspzYeYlsPwkfB+v?=
 =?us-ascii?Q?0d26CFt5tmeluDxV5VqTOHT+HgerbBfBdwS+xA6DI96dNluoOYnNXvWOsrDs?=
 =?us-ascii?Q?GM94tX7qVsvFFgqTfYKVXLqir9baO78tsaenG6Lrj30n+oNC/2Vi2APc3Fnj?=
 =?us-ascii?Q?YHaRkXyz0uCgdgkTnzBErLXzbJLkL4+mp4ZhaVoOLQnLfaQPRsAXaOzJ6eP0?=
 =?us-ascii?Q?L37r/VmkW0lMRvnmV+gLJSGedW1BQDT+aZCwU8ufrE7zAwJ451LWhuWL8WoW?=
 =?us-ascii?Q?IJpflIQ4tyhkxu7Ng5/UPEL6DjJXPfiJJbfqM1KstYjMzoQRO2rFReJd1zLu?=
 =?us-ascii?Q?69ni06jim9Y94cIrpLXQKgf5hnadQhvSIxO93JvwUUdFyTpXlqr6QPuG/aui?=
 =?us-ascii?Q?2aPypMKs5EGXmx5EnQ/V397SP56vN46peHWrNEH8hM3w6gz6tkILGCxLc479?=
 =?us-ascii?Q?HWwWyVyOVvfJE9Uw3If1xvLnnpi987rHh6/4lTUh1zynNMZ+9SPqHh5S/O0v?=
 =?us-ascii?Q?PpI8hPkg+o+g4HCQm4Z5VoIrfaLCwZVp8eJ6kez1S9ver0nDAVpsOdy+mjxL?=
 =?us-ascii?Q?jynYktLifeo2P0yWCF6nmi5j01/GNddq9+Qox2lLwVqVH/7iSx4txcNbLKTl?=
 =?us-ascii?Q?1rMINpQKfpjynHmAa3s/iw3cMBbfKmJ2IXbbDwg0lyWGBGV3v3hvrVpQp3ko?=
 =?us-ascii?Q?YFnfIqlgn70oTrPxlr/zVS5J0qFOQTWVhGEET5K0p1ITlVYVbtMK40ssu5RT?=
 =?us-ascii?Q?uBiX+khGLGXenODK1vbrAQ1mBfOgnxxjswMFZHYX5wbCqToT6DeoFoDAYs7w?=
 =?us-ascii?Q?LVhc7cKF4uvYKx7fcaWOxc3usU0xFBnBleFuznLbsvInQ0Mu3GS5T+UXXZJZ?=
 =?us-ascii?Q?VN6FhL4v+IdT8pUzgGiA4I6VFdby/kO3APEkLTXWFzGcRIvikysxksvzXn44?=
 =?us-ascii?Q?OtaitG0dB4JVRsRS0VIsoO/M076jwtNvGwWtYGIZeqcXrUM0JHttjdBtb1xu?=
 =?us-ascii?Q?UM37Zu+sOtkf4qSoktPK1uqt6lySoU97eDTCszzRayGMi3EFOcJj+i8DtvDL?=
 =?us-ascii?Q?Vzl6kJxAK8Ohe71kZxPzP1R9DCi2DB8APsTvLlb+56HPxLHV3+PZ57lgVMZN?=
 =?us-ascii?Q?11WXu17g62e0vxkP6nytHGhhMnepOzf17DqN1COYUTbrVei1PoUNeUlFnKOr?=
 =?us-ascii?Q?GuEChslKNy9XnWQlMKLnu9y8hNFPVFEVdfkDtOYRw35NuKstYC4tlvll+nSF?=
 =?us-ascii?Q?8vXQ8xaKBHCKf95zW4UDYwlc3+oGUeUCOfcGG9LKsslNhL94Z0rza9qLCZHU?=
 =?us-ascii?Q?/TQhTPhEcmoP7ksJOpqLxedJoji9eLDdYs2yX7qyp6jqPTS7CK96ol5HKM34?=
 =?us-ascii?Q?wVx7XAm2X02b/QfEOUt6XmV5qSvSzgWzjmMc+8fLLlFnmg7zYKd5YB894Bs3?=
 =?us-ascii?Q?w2DRUaYdp7ce0w4XgCFzbt/NpkHh5a97?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Rnjgo+81YqaWJodmx1qqKceS8X22hmZMrfNA9rwYxKw8ERS2ySmlwh4OANaa?=
 =?us-ascii?Q?uQisnXmkdO1poMNNY0vJjw+rAW6W3maiPAC2qkfcTotC15L6mB8jS9jqeCe9?=
 =?us-ascii?Q?IF1DZoMgsm2QAxdsoV3arx3Q9dVREeBir+fOKw0af9YfMwzvhca38u48mV5p?=
 =?us-ascii?Q?/sQk4L5HsETq3tCY8+shcmlE5SDbae+UUXsP3YB0WvC7JaPv//6I1qa7e2Mv?=
 =?us-ascii?Q?qdnFVMHkYkxoPu19byhaT97GiTUDymD/Df4ZWD+WdnGPMxPPwEXskTPqSgRY?=
 =?us-ascii?Q?lawORaLxT8Xf4ZUhHksD7N6QboE7KRUODOSQLJW8ZZrHUX3Bu5RubIhq0I3k?=
 =?us-ascii?Q?BKkUVu7HbYghRzSv9PoES7JXWwSFtR5A0EaeRN8dBakpnJt3L5w2cwuw6egW?=
 =?us-ascii?Q?F6Qc4FKECDHLKpGVKz1yQfWx9kVKT3mQPuHw16lZxc13CUaIU/sR1OxL+5Kr?=
 =?us-ascii?Q?USKbJTz33KbuJb/VJV43S91z5pPhQXS0Vy1OBel0wTKYFOPGIeZXw9KeuL0H?=
 =?us-ascii?Q?E+LCJVLg/DqRAwlPwid+pSZLvgqjZqNh2ANZMwP6RYY0HWWsujR/MMwm9vOT?=
 =?us-ascii?Q?/eydd7iJOWrdUFsFE6D+RBCUHpfkpI4WPVDq5HT1ie2X9O97mgIfSKD74LJS?=
 =?us-ascii?Q?IlD0g6rsfVo4Wf5zku5qKIW4kcNSQDHmK3BdeW8Mdi4yqUmlkhWUmd54ymWo?=
 =?us-ascii?Q?PnSLQP6hMmWpxt0ScAtw23IdThQmyDXh2AQVAkWtC57EE9AW7OfaGBijfgDE?=
 =?us-ascii?Q?TXjC8PuQ6QHAw5Tcp5PSc+7mFRZbDV83CKWwptwrcshQ/q3bS23HwPD9J/uT?=
 =?us-ascii?Q?Ox6xfR8kY2pekEs09aO6AkBc/4IuWr6cT43x8nkjLCswJcI/MArQlDOOJMIJ?=
 =?us-ascii?Q?k+HUjyjpo9uS9FHKZ0Paq/qzLsnPyelac4yls5oxLrxrkxvKO/JVwL3ju1Ol?=
 =?us-ascii?Q?WVQgzg4/p6MZZKrNgiKMIqre1zo+hAWUP4OzaRvxC4SyJWTr089bRKHmOGK9?=
 =?us-ascii?Q?ALxYqyyBlN/0XGDGIryaTEwZ5KG3pCWgG8hEXiiCr1ZkYkH3JS1SvqHf1BhS?=
 =?us-ascii?Q?i8lKgHrq71eHUqBaaFF8ErJMpgk2jOB1FFO+bPv6m91km1Q6gb8pbPyHtrC4?=
 =?us-ascii?Q?g+08dVi/mu1KR2A3FAghdwBlYtuie7Djf9+MCqigP7lUg3cRDyTjebXx5wIY?=
 =?us-ascii?Q?S0alwd7Cszu0QMfs5d5NIEHJbO7lwry5mGkvlsWZ2co6vxla4C+3QBf7nt0q?=
 =?us-ascii?Q?jJLrH12FRlRHA9KSIQuwV6t5kBrfPhH8MFoMVVYCcM3vFfWQVtmpgqe5BTmF?=
 =?us-ascii?Q?eIMODmxWwwMZV2V7zCkqKILa22bhUTCWdQTfSUHoT+i1+ICVP+OazC4/azrk?=
 =?us-ascii?Q?9i2hlgtq3Dcs3wPjieLA+gRjRkmrXeY8xT+z3y7sDNa33YuG86TVP5okDXtH?=
 =?us-ascii?Q?g0J8F9FUcKS5SuZbX5dOQ68P7hpO1JY0YFAR7U5OjAKSVIjyf1keEUk4ZhsE?=
 =?us-ascii?Q?tVPG/VTTgclbJXGm6ntsiqQBzh7BvaJlOqWI+zLR2aVP3X/413sVuROWmyNq?=
 =?us-ascii?Q?HWbS24+spZ8LPf6+2QTNiZdLosFg2nNiobCMZLa4v87jY+jLyYwzzPqe/kcS?=
 =?us-ascii?Q?ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4DB523EEEF4574EA2AF2726EA518035@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PAY7C4PqVyxXEn5xUOUt6Di10Uwi4kWI1xhlVm/PWbxZWLK16KwB7JI1ANRRf+QCFqtfRKT/QL9UybQoODvdhgwAiS/SkvM+k5VS5NC8mCbLr+PfAl7bxJNl8AD6WjzCR/g1+z27iVqB2ufKaFp22U5FJc+s/+4gqX6Lr5hVlJJotGitb4J55Ll0C0sK3SYNg0oGjdAjcF3mudoLNBSx5EkCVnSzR4ahuIZoABPBqWE+3bFO9vSChY+7a+h/F38QDt31wBkCqsxwW5ZZSC6qz0iHjU3DzH0rSagwFOlfCD2IZQdKZogUjM8qnjIFMIUymMFp1mO/iXMEsalMlsrWsOn49bYzYsHSaMWkPaWv8522EW3hf2cfhCv6fsomc6EYDuK+tbmdGORqvU7PzMudBO9uLnrSU1I5jDt+OzROejiBngrsKE6ZMTKZmU6qZPtKsi33I9r2f5qHRDZQgtZ7zn+vkWmS/8T4sck0I8YMxLMcTS6VbKmyRn22tu03qlKXHBL9HmcsXUCQV+dRg1OdXXSV4pHcckwlj/kYQxz2rnNZgtAMfQcAjMr/Oo46ENRuVS5ZXIw4P4FT4uXNunzGWG5stQyUC9r/kdo0hkQjaPHchwz4nSPWHE0/qyhqzHqc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0987fa-cd21-4c68-8c3b-08dd1f283d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 05:53:04.5875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AftNzOd4Cj2JFvzIqGMYznYQXcHbSddNp+KvjaOKVS6QUs3q1BTi3ce/7SZ817e6AVH6Vydz2g1g5QcdHtDEZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9264

On Tue, Dec 17, 2024 at 02:13:13AM +0800, Anand Jain wrote:
> This feature balances I/O across the striped devices when reading from
> RAID1 blocks.
>=20
>    echo round-robin[:min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_pol=
icy
>=20
> The min_contiguous_read parameter defines the minimum read size before
> switching to the next mirrored device. This setting is optional, with a
> default value of 256 KiB.
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/sysfs.c   | 44 +++++++++++++++++++++++++++-
>  fs/btrfs/volumes.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.h | 11 +++++++
>  3 files changed, 127 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 9c7bedf974d2..b0e1fb787ce6 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1305,7 +1305,12 @@ static ssize_t btrfs_temp_fsid_show(struct kobject=
 *kobj,
>  }
>  BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
> =20
> -static const char * const btrfs_read_policy_name[] =3D { "pid" };
> +static const char *btrfs_read_policy_name[] =3D {
> +	"pid",
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	"round-robin",
> +#endif
> +};
> =20
>  static int btrfs_read_policy_to_enum(const char *str, s64 *value)
>  {
> @@ -1359,6 +1364,12 @@ static ssize_t btrfs_read_policy_show(struct kobje=
ct *kobj,
> =20
>  		ret +=3D sysfs_emit_at(buf, ret, "%s", btrfs_read_policy_name[i]);
> =20
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +		if (i =3D=3D BTRFS_READ_POLICY_RR)
> +			ret +=3D sysfs_emit_at(buf, ret, ":%d",
> +					     fs_devices->rr_min_contiguous_read);

I guess we want READ_ONCE() here as well.

> +#endif
> +
>  		if (i =3D=3D policy)
>  			ret +=3D sysfs_emit_at(buf, ret, "]");
>  	}
> @@ -1380,6 +1391,37 @@ static ssize_t btrfs_read_policy_store(struct kobj=
ect *kobj,
>  	if (index =3D=3D -EINVAL)
>  		return -EINVAL;
> =20
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	if (index =3D=3D BTRFS_READ_POLICY_RR) {
> +		if (value !=3D -1) {
> +			u32 sectorsize =3D fs_devices->fs_info->sectorsize;
> +
> +			if (!IS_ALIGNED(value, sectorsize)) {
> +				u64 temp_value =3D round_up(value, sectorsize);
> +
> +				btrfs_warn(fs_devices->fs_info,
> +"read_policy: min contiguous read %lld should be multiples of the sector=
size %u, rounded to %llu",
> +					  value, sectorsize, temp_value);
> +				value =3D temp_value;
> +			}
> +		} else {
> +			value =3D BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ;
> +		}
> +
> +		if (index !=3D READ_ONCE(fs_devices->read_policy) ||
> +		    value !=3D READ_ONCE(fs_devices->rr_min_contiguous_read)) {
> +			WRITE_ONCE(fs_devices->read_policy, index);
> +			WRITE_ONCE(fs_devices->rr_min_contiguous_read, value);
> +			atomic_set(&fs_devices->total_reads, 0);
> +
> +			btrfs_info(fs_devices->fs_info, "read policy set to '%s:%lld'",
> +				   btrfs_read_policy_name[index], value);
> +
> +		}
> +
> +		return len;
> +	}
> +#endif
>  	if (index !=3D READ_ONCE(fs_devices->read_policy)) {
>  		WRITE_ONCE(fs_devices->read_policy, index);
>  		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fe5ceea2ba0b..77c3b66d56a0 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1328,6 +1328,9 @@ static int open_fs_devices(struct btrfs_fs_devices =
*fs_devices,
>  	fs_devices->total_rw_bytes =3D 0;
>  	fs_devices->chunk_alloc_policy =3D BTRFS_CHUNK_ALLOC_REGULAR;
>  	fs_devices->read_policy =3D BTRFS_READ_POLICY_PID;
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	fs_devices->rr_min_contiguous_read =3D BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_=
READ;
> +#endif
> =20
>  	return 0;
>  }
> @@ -5959,6 +5962,71 @@ unsigned long btrfs_full_stripe_len(struct btrfs_f=
s_info *fs_info,
>  	return len;
>  }
> =20
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +struct stripe_mirror {
> +	u64 devid;
> +	int num;
> +};
> +
> +static int btrfs_cmp_devid(const void *a, const void *b)
> +{
> +	const struct stripe_mirror *s1 =3D (struct stripe_mirror *)a;
> +	const struct stripe_mirror *s2 =3D (struct stripe_mirror *)b;
> +
> +	if (s1->devid < s2->devid)
> +		return -1;
> +	if (s1->devid > s2->devid)
> +		return 1;
> +	return 0;
> +}
> +
> +/*
> + * btrfs_read_rr.
> + *
> + * Select a stripe for reading using a round-robin algorithm:
> + *
> + *  1. Compute the read cycle as the total sectors read divided by the m=
inimum
> + *  sectors per device.
> + *  2. Determine the stripe number for the current read by taking the mo=
dulus
> + *  of the read cycle with the total number of stripes:
> + *
> + *      stripe index =3D (total sectors / min sectors per dev) % num str=
ipes
> + *
> + * The calculated stripe index is then used to select the corresponding =
device
> + * from the list of devices, which is ordered by devid.
> + */
> +static int btrfs_read_rr(struct btrfs_chunk_map *map, int first, int num=
_stripe)
> +{
> +	struct stripe_mirror stripes[BTRFS_RAID1_MAX_MIRRORS] =3D {0};
> +	struct btrfs_fs_devices *fs_devices;
> +	struct btrfs_device *device;
> +	int read_cycle;
> +	int index;
> +	int ret_stripe;
> +	int total_reads;
> +	int reads_per_dev =3D 0;
> +
> +	device =3D map->stripes[first].dev;
> +
> +	fs_devices =3D device->fs_devices;
> +	reads_per_dev =3D fs_devices->rr_min_contiguous_read >> SECTOR_SHIFT;

Want READ_ONCE() as well. Also, is it OK to divide it with (1 <<
SECTOR_SHIFT), which is not necessary equal to fs_info->sectorsize?

> +	index =3D 0;
> +	for (int i =3D first; i < first + num_stripe; i++) {
> +		stripes[index].devid =3D map->stripes[i].dev->devid;
> +		stripes[index].num =3D i;
> +		index++;
> +	}
> +	sort(stripes, num_stripe, sizeof(struct stripe_mirror),
> +	     btrfs_cmp_devid, NULL);
> +
> +	total_reads =3D atomic_inc_return(&fs_devices->total_reads);
> +	read_cycle =3D total_reads / reads_per_dev;
> +	ret_stripe =3D stripes[read_cycle % num_stripe].num;

I'm not sure the logic here. Since the code increments the total_reads
counter by 1, can we assume this function is invoked per
fs_info->sectorsize?

> +
> +	return ret_stripe;
> +}
> +#endif
> +
>  static int find_live_mirror(struct btrfs_fs_info *fs_info,
>  			    struct btrfs_chunk_map *map, int first,
>  			    int dev_replace_is_ongoing)
> @@ -5988,6 +6056,11 @@ static int find_live_mirror(struct btrfs_fs_info *=
fs_info,
>  	case BTRFS_READ_POLICY_PID:
>  		preferred_mirror =3D first + (current->pid % num_stripes);
>  		break;
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	case BTRFS_READ_POLICY_RR:
> +		preferred_mirror =3D btrfs_read_rr(map, first, num_stripes);
> +		break;
> +#endif
>  	}
> =20
>  	if (dev_replace_is_ongoing &&
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 3a416b1bc24c..b7b130ce0b10 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -296,6 +296,8 @@ enum btrfs_chunk_allocation_policy {
>  	BTRFS_CHUNK_ALLOC_ZONED,
>  };
> =20
> +#define BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ	(SZ_256K)
> +#define BTRFS_RAID1_MAX_MIRRORS			(4)
>  /*
>   * Read policies for mirrored block group profiles, read picks the strip=
e based
>   * on these policies.
> @@ -303,6 +305,10 @@ enum btrfs_chunk_allocation_policy {
>  enum btrfs_read_policy {
>  	/* Use process PID to choose the stripe */
>  	BTRFS_READ_POLICY_PID,
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	/* Balancing raid1 reads across all striped devices (round-robin) */
> +	BTRFS_READ_POLICY_RR,
> +#endif
>  	BTRFS_NR_READ_POLICY,
>  };
> =20
> @@ -431,6 +437,11 @@ struct btrfs_fs_devices {
>  	enum btrfs_read_policy read_policy;
> =20
>  #ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	/* IO stat, read counter. */
> +	atomic_t total_reads;
> +	/* Min contiguous reads before switching to next device. */
> +	int rr_min_contiguous_read;
> +
>  	/* Checksum mode - offload it or do it synchronously. */
>  	enum btrfs_offload_csum_mode offload_csum_mode;
>  #endif
> --=20
> 2.47.0
> =

