Return-Path: <linux-btrfs+bounces-8191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69EF983D90
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 09:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1924BB24026
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 07:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3FA12CDBA;
	Tue, 24 Sep 2024 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BQ89lOp0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EbJ3R3Qm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB00C12CD89;
	Tue, 24 Sep 2024 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161626; cv=fail; b=Mrlp2Fco/LwWOrmQyuAVdfEcXGv+C2jdTsDc2MmY2kRs0oWmebf7eoETWw/ap+YISaP709UzBoR/5Kpc+ZuwwYScQXLjeqJ6k2ACoh0EutUMg/0RQ9gws7mBucGa1Z4h8hgqwDp04n/tMd9pqjWcHpvAXiMxTRvpaxU2lLXJq94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161626; c=relaxed/simple;
	bh=n4QPJjgwgInrbBucheGykKWR/kBQM3gDKn/RzBfbFo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PyVSs7muzDMhO5v85o9o8jE62ymKLOHVJtjW1JeBqrbdr/IsW4WYuzLcdvKTvCCq8OpTgfWMT3Gcj8WduL5aeQdwaMuPUsjTlnBsI30OtrDBrFjTYwCyb/RCeeH+VpOhYc2NlE3+RZNGIFWfOv+Aoy4wkDseaqrXfrLfDrGjqa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BQ89lOp0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=EbJ3R3Qm; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727161624; x=1758697624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n4QPJjgwgInrbBucheGykKWR/kBQM3gDKn/RzBfbFo0=;
  b=BQ89lOp07sd0MWbOHlKBQ0bMwoBVHOrIb5Fkmc0+HQn7NG6jDTXsND9s
   vSL1nCeDa71WODgBVIehFORPrQemD8Nc6IyWpOvPrpsdj9iSHZVJjvuoR
   H0pbdRmGsw8/uBktZojiwblmJSLrdSTNCHvBExVNBf6bE3jj6t7fHTMOc
   akiPM90sc7VIQdrybsqn+46J171wQCa8vpMMFCZzjn98YYE2lO7LuxONK
   0uontFDTqaU5iEvZENzxqhguxiNWQZA4XR4BT4U3+fZZ2RMh9jggaqxwn
   d6I8gf/LGrmsReT1y/16iy0gfHuufBn2or4Niyb84E1nqd+MpMGhD9w7C
   w==;
X-CSE-ConnectionGUID: yNkpr2pKQSSZwOHgS5r2Tw==
X-CSE-MsgGUID: JdfxzA8DQveAznWqg9dqpw==
X-IronPort-AV: E=Sophos;i="6.10,253,1719849600"; 
   d="scan'208";a="28434536"
Received: from mail-bn7nam10lp2040.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.40])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2024 15:07:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiLM6qj26X1cljusyRHAjXzDrn9n9BNUO7CI29qvg0I/DhVjG/xSRZ+Id2gS0cDNAYKIthIwedbA2C2DK+3F/MJDO3+5vmd+sGKLQmYxj07w4HQDv35XgmGfurhWJfpyhsTTYGsiYEtixQ9LQjJD2ZyjaSLiHUD5bNDKq79v9oOuDb9V6EdHWrsNmeaTNh6gvb+vszeRbNwE/0lm9PeKW3VkdE4czewzFL8ZgmJz9BNaMazlX8+EWoUMKytXX8EFVHI+5jsHuXQ/JI9nqFIkJQMYQelgm8dHspm6G5QYoiqZeyYSJ8AlzQbNdCkvB2jDV/D2IEhTRnEC6d8Y1A0NWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrfTC2oPu4nCpJRu4iLikvEFEKvJsHHfT10P69e68nM=;
 b=o7SwqQZBtsaKXqu3EyyaTrxLGb/HFvuNmeykNTHJ3OMmL2rg2MPJR5Y2E6GAfj4PYInfeQVE4Nr0Ipk4NYgQZ+llzNKOqgsbAJZVYv5LKi9l0Jcw3E0W1GPmWV+BAimbP2Oq74Iv1qwfTdHlStFmpR7/TjV9mOpbVpAUCCDXn2DffDGvNVbkwvgf7fWdSgr0G/1je58ugBZJwrjHllvDJqelNapmu5jBDBb4UuiMxq6bQoVnqycRcw59dHMZsVoe+MA/eYb7HeVjkdM2MFn8Pz3M4ZL/5EsD7wtpLNRiB6PIE0PTgr9DNGfmQWoG7A1038XzWhmLjcS3FOk0Y3fm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrfTC2oPu4nCpJRu4iLikvEFEKvJsHHfT10P69e68nM=;
 b=EbJ3R3Qmp0SKymq1C//4qcJYbkKzUxQUY3FDX8RlUXImsZE9YN9oMl76e/z8hlWg0kHNsw1ybVjGSMZH4Ulf/DTqbmn7O8GFki3BJzZ+reDXRLjxxkPTBGwmVY+4Mb6bx5gS3SivvTXgqv8FuVHyoFdkxd8keHdhUelKcetG8qQ=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DS1PR04MB9199.namprd04.prod.outlook.com (2603:10b6:8:1ee::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 07:07:00 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 07:07:00 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "open list:BTRFS FILE SYSTEM"
	<linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	WenRuo Qu <wqu@suse.com>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: also add stripe entries for NOCOW writes
Thread-Topic: [PATCH] btrfs: also add stripe entries for NOCOW writes
Thread-Index: AQHbDYRH4xaGuNSE80WNZwmVr637RbJmhaKA
Date: Tue, 24 Sep 2024 07:07:00 +0000
Message-ID: <kcngaxzwlgh4jm53j632mnlp2ebo6ddf4wvkaicn2mllos5p4k@xwyhwq5lbl3d>
References: <20240923064549.14224-1-jth@kernel.org>
In-Reply-To: <20240923064549.14224-1-jth@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DS1PR04MB9199:EE_
x-ms-office365-filtering-correlation-id: 5b56000b-880a-460e-845e-08dcdc677c43
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3eOtoG+O79d0vqerHDqtUEmBmNnFtJ0jWHHcE+Orhw9ycE783aiBTZlLA+yM?=
 =?us-ascii?Q?vFB45APw6VpleJCJGNk9xqn09KRIMqxFEhbzum4yCpd3acXhvYOuCqXzCc9R?=
 =?us-ascii?Q?JGw+OvIu6ENMdCD1mLyYCiqXTwDBwBvcs/KqoNuaXxf+YLMP7KLlu677WkDX?=
 =?us-ascii?Q?SqioEcaMYlvUFGb4SsC9pTuGiE3qEBDKwQA0+CS3xMuyienLMrcVrZPe8GEU?=
 =?us-ascii?Q?Sb7IUgPgXytc5oiERc4Iw5+YxsXJQtDhadZagUn7IAweIq8SdWEAgwlFdCiC?=
 =?us-ascii?Q?IW+H9HhT7KJSzzteiZIgp2Po0RqmblJFhxNaSoU0mxDlDNqrNjrfjVwa1Fhd?=
 =?us-ascii?Q?oiwWwRxPajuVpz3WWZcEb7N4eRHIzrQqKWCl+YG6HlI6AJuCO0ESBC6fsxF5?=
 =?us-ascii?Q?ySzR1t+a5o93QF+Nbv+/ybVNtWMLla37I8S2pTZ4+yoFL+3YpCcHqyiVxQbZ?=
 =?us-ascii?Q?+RGLxE1bfrnle6E3OF2pJnA2A86VBiql1A4cuW6sjKuDfs797ANMRt89G9ZM?=
 =?us-ascii?Q?3LCeqRc4vOm5Xq7xLZ11qVmihq30iDZSk78swGvnZmlu2+NM8/RYUKAXu57b?=
 =?us-ascii?Q?x6ZIeZnyO1FYiytFICQ/qhWjZ2UhSxl1b/kKEcG5qFAflTI8rYepg5PNhXWI?=
 =?us-ascii?Q?ATk5JgoR7pi5k1IsebkCejJT92pauAFqONa8W1QWzRQd9QqiVHpA41yUOg6A?=
 =?us-ascii?Q?/uVNLFMPc+sDBhwA051vEwGrPrmmwBj1d/IGuCHNfguFUtESNj3XbBg0BDSN?=
 =?us-ascii?Q?WBQFcvG/a4RU1BJUP8hWSefvyo5g4HdvWpTutinslaKOhZewViNn3z+Ec7Ud?=
 =?us-ascii?Q?tZgM5+SRXr8U80Lek/XF0nYiYZzn6ZEPRy3MRIvhDRrlqJ6HkOEFtakDo3tz?=
 =?us-ascii?Q?/RBdRwOY0x4XIkKW2AXM3gc7y3mnMO8mldgNeubRRG/GN0H6JQPAE03jqVEc?=
 =?us-ascii?Q?dkywPOEDy/zDZAyRbjXpFBQU0AbUyHbuS2oC83JKnVhpyhDep/nJQ/fAwr15?=
 =?us-ascii?Q?O7tt+zfcdoZaQ8NGJ/SGYLqrGBKMxO8qpcQErpPihF0uZyeBJ1Fg629Zw2uX?=
 =?us-ascii?Q?0lJi/tEhPoCzZRgmO/js/pL7tkzNuJ9Aa+YStTZ6bl5HfP+3y9O9K0raMn++?=
 =?us-ascii?Q?zm+JSNSmRtjVbtK+eqK0w5X0fR221U6o0gw3oRdOXrTwuH0MAelWvJqwzhMM?=
 =?us-ascii?Q?ZZ99MsNQ68bKBvqatZqkp9+ta1jc6qFqNNgS6wv0WM4F3JCqe/RGvt24pw4u?=
 =?us-ascii?Q?M0ryp/u6tH8Imc/QYxhGdqeHKAYtyJb5Kpd784h3PHEYm7aRpiYS/GqRJK62?=
 =?us-ascii?Q?1bxqBMc41ZEid2gzG/KIPqRJHqV+RWBUqOIVbxu3HzfpiTpqSIKg7/cLjM+6?=
 =?us-ascii?Q?feb8JFnHZhjs2WBgy8NjQSQtlNfXNY4ZCkiEXYhACRYc2bXzDA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YqQQ6p+EtRL5vvzVzK1elNcZ6DfzzdtY0usPGZutLGJuGaTC5UlOKceDFW4L?=
 =?us-ascii?Q?h8eHhSBb/3JrMs3Gp2nFpfbAJUZchBn964eEVPVfRwyzbijGdLYh6FL9JnQG?=
 =?us-ascii?Q?GCi9dibVGqa7cs7M6M8THPS4MeoMR5Kz1b9wU3Rl4h7auFpt+x0d4K01wijr?=
 =?us-ascii?Q?NAUgTOASSe2+k9S1IaKGRyUnSKktLGPv6O6ZXGqx+9UtF4DSNcjmCwsfiBoR?=
 =?us-ascii?Q?DjPWpqcyEq8JcSAG/0WSma2d8T6VlTXPOrjTk7QKr0r5hDurU/756wrOJxop?=
 =?us-ascii?Q?2t0Xr+A1NP4Q5g372kcv+baDHa5G6+fmG9WsDvd55veCF/COOyI4Wr9nqwfj?=
 =?us-ascii?Q?ugkCwVblbMIkSbUcEq31v20Ll+LZqTTrMHppzAug2KVUHRtUTkg/lmO/zCAK?=
 =?us-ascii?Q?OT2ojLlviwAsKt2k5EMRJJ103HEDRUJjjkP4kYMiSevJ0KkwAyQ3Pe2YM6aq?=
 =?us-ascii?Q?lmgXK3JF7tJtCqa3I+zHMRI5493hiJLxAZqbbkFBpOPUmO1PjCKBcKI4amR4?=
 =?us-ascii?Q?hykcc5KEyvDSWdZBBTayZ54QZ0WGxZp7nSOJuqLUzTeRNqzslKhSoEtaVFVr?=
 =?us-ascii?Q?S493iJEtME5/35ymKOsF3Y3+k/4teyjdOWj1WqsvgoxpvMAGsPMmg3YjfL3d?=
 =?us-ascii?Q?0rSGF5w1M5VxHo6UU9AwIcbGIN/Zeo2JNQqt0da5LkLK7VfDfq+Ou6bN87w4?=
 =?us-ascii?Q?U3HBOgivgkAexgUluA8Ko4Ayg3uBeZ6MVu8jnKI/49WGx0zcqzUcag+ma/AU?=
 =?us-ascii?Q?IDkuTUPQTpSwtxSeQIXa/KRENgv9bYF+NCvwOmVGJPZH+90wGOEvHKcWl8Rl?=
 =?us-ascii?Q?t95nT3SacGuhIO3r/cioNJVZS+yTuqinVQSS6E9Ots55Y4zifyrCYQpnuX0z?=
 =?us-ascii?Q?oyqWV9dwpH/iArMlMEfBfow4QRrnTNvAVt0OoumV/fgh8Bu/KzVUL+42/MTP?=
 =?us-ascii?Q?5IQPRfzsTO1cn51ncKCTgSlY+THfTugcllgylFBLU5NhuwN5okqLdZSNxubr?=
 =?us-ascii?Q?QE10e1zkn9V9fGGEJBw7lFX5F201mpUk8vu54WuLSEGWvGwS0eegFYf6chTi?=
 =?us-ascii?Q?uUtv6yuDRTj7kQkImah3L8Vi1PbwV5b5rsQPhWqFTCb+4RJyNkHXVAKGoEYJ?=
 =?us-ascii?Q?wI3PkLNnSVSV/O4C3eZDIOzYRqJxMlIAhq5MKqg+MZYtLA9fLqLFemvOsllb?=
 =?us-ascii?Q?+iM5QmJMWEUnI2suUFuurInb24C0XvSaDx31FaTlOJU+CBqGFywJ+rT53yoL?=
 =?us-ascii?Q?OEhmtTI7Pjcb3wKYRqrYCKfLSvMdy05Z2IQAovi3nA9UMiapZKuGZI5zjs4c?=
 =?us-ascii?Q?sqQAKeyo6QmT8KzGxwmR9dwuDrtpBoYRN1rpVa34WtLg3VII7esBTkvcrrEG?=
 =?us-ascii?Q?b81SCdJw8YX4M7Ez086qJdeOACAw9edmDuggnPw94NOp+IuYfYPO9cGm6A2M?=
 =?us-ascii?Q?UG9/LcoONmMTVGf2sPjshss3FW+4lWVUZ0uJN+hhcBYp5+2alVUswymAh1Ff?=
 =?us-ascii?Q?BxeNGuEw3SUC7LWsqUgpIUmRJzTChYREoxmYScJWKsOiLC5YLWEOPXkO3Zka?=
 =?us-ascii?Q?5vX4OCP0oYj0ZTSBNmXOltJzTZUbl1t5HfXgt2p4JIxAmOKEXhU7CNqXpUpS?=
 =?us-ascii?Q?Dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D545AF806814543ACA5467DB1887D9D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+OrLLMJcf8nofQloTFTgrjvYLwbb+Put+exznBqs91tgP1uTqgzzXlELBAquN0jk4Pp7Lnhh9Lz3usEbbJLser3X816kCpt1N3QvVLBsBSZQ/3AwCVLJuNt2iE5M+ZLi7h3vNORqnAQisALkTrn8dRFf/XrySpKUo9xyDkDR4Sl2impc1Qwot6c5+YwH/owuaN8n3+HTRg9Cbju+lVsQSzGTBVcseolLxK16mG4D/hscRRcWv14oJlreLlwdxr0ROmb7jnZmZNDuLuN7IrwiGfY/i7II/dybcPiVD2fxBt4XJafYdD9NfrL/HMe1oy9ZZWSbI4x32lxJEMn4y8W5SKHcbN90SHAoG2f/yUTjvJtaiIqalLllIQJ3qu1oOcq03H5xmNuaoRPOMT5eWdQ8tQudjs3wrzStfGmknXnH4B+kehyAoo4B4dE2JoO9vajkrXkCJZYBldtDdVS/RNhfG/HCfW1Jlz3zm7ls2Luy4BrDVPOYPk3QJ7+PwPxrkcUIznR+Pp2GxnB/SS/XJIJXHMEKmrRNakm78THNg5xXgzF6nDmpyWMvpsHBVaB1sKg2i6YfhhuyUULbgvItAC97L/4i6/BmENL7DRY+BxIqbLNZQgFWYcMiqchKPJ6tpw8D
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b56000b-880a-460e-845e-08dcdc677c43
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 07:07:00.3993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L37uM4Wy6j4hnm0B5h9Wk195d+KEk+dACxj0a1vBntDyRGq/gveRztQ8G5k7OnOCTQPjZu2Kpjv3XEpTLzcGWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9199

On Mon, Sep 23, 2024 at 08:45:47AM GMT, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> NOCOW writes do not generate stripe_extent entries in the RAID stripe
> tree, as the RAID stripe-tree feature initially was designed with a
> zoned filesystem in mind and on a zoned filesystem, we do not allow NOCOW
> writes. But the RAID stripe-tree feature is independent from the zoned
> feature, so we must also allow NOCOW writes for zoned filesystems.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

The NCOW case itself looks fine for me.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

But, looking around the context, since there are some duplication among
regular and NOCOW case, it would be good time to merge them.

Apparently, btrfs_insert_raid_extent() in the regular case (current code)
should abort the transaction as same as this patch. With that fixed, code
will become really similar.

> ---
>  fs/btrfs/inode.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index edac499fd83d..c6e4b58c334c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3111,6 +3111,11 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_=
extent *ordered_extent)
>  		ret =3D btrfs_update_inode_fallback(trans, inode);
>  		if (ret) /* -ENOMEM or corruption */
>  			btrfs_abort_transaction(trans, ret);
> +
> +		ret =3D btrfs_insert_raid_extent(trans, ordered_extent);
> +		if (ret)
> +			btrfs_abort_transaction(trans, ret);
> +
>  		goto out;
>  	}
> =20
> --=20
> 2.43.0
> =

