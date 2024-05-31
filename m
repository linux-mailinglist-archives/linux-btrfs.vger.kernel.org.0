Return-Path: <linux-btrfs+bounces-5375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394648D5DA5
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 11:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D09E1C2486B
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 09:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C83156641;
	Fri, 31 May 2024 09:04:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C035E153BE8
	for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2024 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146267; cv=fail; b=t76Vr62CDZTnZL4FEdGD+mRWt6SOhaI4/twvLXASnBDp7xBWTZNrbcivMjRNLdQJs+hlnDHVzV8pm6yFUuZvmO10r8QBj7RM8197kARjvnih6Vbo/P+F3v7RHQGKFhbyjVbSZVlLUlj0GXYtteGdAhVgC+t2Xl38HRBct6hYmZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146267; c=relaxed/simple;
	bh=Ae/pRXg380Y0YJW2FxTbLJIvs3JPGqeydIe2xzlHwGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jqIMmMNTQHPnD+i5Qv7g8oZzA/h6l+xJ0ihyT+kGrW3jKMQ2I5+t7fV6Bb/vhNfhbD95pP4jsHccqP49BflmnThljM1s6SI59d28aAnWWJtErRMK/U91lUgwz1t6Lr8+5Xl/sLZbEkAyNw8tM5RDjro/ag7a0fFC8l86C8joSXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V93u1F027642;
	Fri, 31 May 2024 09:04:16 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DlZAnHgqUdk4EaHdZzrLUpxR3x6I6BDKyzBn/W9JWj6k=3D;_b?=
 =?UTF-8?Q?=3DOgrrMBcfgITlQVrnxqVlGHJwVObUFhw5Ci7smfbqTP4M2zKa8T9TdhKS8Iki?=
 =?UTF-8?Q?Z3Z7feVd_XDQMyamkhnVsRxYavyPdUk834Pylj14LG8qPDy79Sc4dMkXx9RatQB?=
 =?UTF-8?Q?hopkfhZL/e8vTb_XEYj4/iimRQL/dpoY2cqA21P42hhKMga/a78tHlVXPvF3/cE?=
 =?UTF-8?Q?y/KftjwN8Py4FZw8mn/B_XZAEAr1j4pu9Ho6JDcy1FIe1jW212mxKHg5SBsUkIn?=
 =?UTF-8?Q?yMHkFu9JuaApWqv2z0Pttv4tAb_Dccla+w3SkZJC3pmkFk23BYr29+0zGkQw8P5?=
 =?UTF-8?Q?AwM0TOIP94MufSN/FLtEtzVApxfuc3q1_7A=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j8amen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 09:04:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44V76mO7020282;
	Fri, 31 May 2024 09:04:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yf7r27jk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 09:04:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBHTGkzan8SKCXqCB5ZUANNQHTGQ+EfbaA8z1tEV5A5wmayJL1BkR6vT6mvNPVS9X/ynUu/H74s9SsH+xW8TdzRNAOzhw14tpg6mcC/Huxtlknnk8c9U/MVu1guODizRP6DtYIWR7cPIOQPbJr7CcUguiVK/31mkq8HC5Nj092WeqRIO+o8wMQ+6hL53CFWJwL61KionDuJ38XJqfSIuNCLBwohEEFEqa+KJJIYCDCd2ddPrapLSUvFNdLafwL8H1AywLuWCQ7+ZY027F/XcesO64rvkvWJXXXXvC88W1pgLntG9SMszzZBzZnweGBucIJD5SnyfXGzrat0CmyZ9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZAnHgqUdk4EaHdZzrLUpxR3x6I6BDKyzBn/W9JWj6k=;
 b=nwvcccRgy16h7vbnf/EkhSkNF8obSl1eMuzNgjjK3Re9pLUVFvsPIyytRVnTxG0v7+3INkh9+UHsEpl4ZcbpllDXk5u+ufYNi9FS7c5hEqCC7ksZVxqB5206jXBliJ8HTRQLZN1FRDYW7KD6yTL2p3Ekw1t2d/MR7aX9WS4t4Y5LjWMdNxEnbf7azSNOJemWEM5YDCeQkeuD3YsxpnlxdOpL1x+MwWrFCuRSOJ+p2vvN5EDoDTd2PblDS+MdhgrWlVYa+nHSyqQ6SfBqamel1iTMFC9PEA4YHY4v0gnu6ebTtPal/2VJ12x4mi+0mgAYYhfDn4YkP+ZDQ/9IS3SYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZAnHgqUdk4EaHdZzrLUpxR3x6I6BDKyzBn/W9JWj6k=;
 b=FPMHXcSXoYdsKZAKxjawmAAFXJjaRZ70J8BVR61kef7g1+oLnOWxh8satgrP9gdsugH552Nd5qkppBa8X+BNtLT9kiTN8I4jNQB2aoUbmPhNLhJ5Y1yTbdWcvMi96r4BQGpmcAR/DX4xDKqKgMf38yL/CPbZCIXES9o/IGEPVWU=
Received: from DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11)
 by MW6PR10MB7614.namprd10.prod.outlook.com (2603:10b6:303:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 09:04:13 +0000
Received: from DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f]) by DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f%5]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 09:04:13 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Rajesh
 Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Junxiao Bi
	<junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com"
	<josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
Subject: RE: [RESEND PATCH] btrfs-progs: convert: Add 64 bit block numbers
 support
Thread-Topic: [RESEND PATCH] btrfs-progs: convert: Add 64 bit block numbers
 support
Thread-Index: AQHasrblbLlLTky0U0i/yX28Adrz+bGxC/mA
Date: Fri, 31 May 2024 09:04:13 +0000
Message-ID: 
 <DM6PR10MB43476059C588E8136707F28DA0FC2@DM6PR10MB4347.namprd10.prod.outlook.com>
References: <20240530053754.4115449-1-srivathsa.d.dara@oracle.com>
 <20240530172916.GB25460@twin.jikos.cz>
In-Reply-To: <20240530172916.GB25460@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB4347:EE_|MW6PR10MB7614:EE_
x-ms-office365-filtering-correlation-id: 15d90741-a8fc-40c3-4030-08dc8150a435
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?A5BQbKsWPoAR2G5eW/UCtocOmp3950FjHT3FF/GiMvti4+1M7gJrzSh0GIUL?=
 =?us-ascii?Q?wrnoc1T/LbN/mh3/qnv5XGxEu/pOGeERUej81tZxw8KNeQihq8igmSkUQnkx?=
 =?us-ascii?Q?XChpMIjoLqwuWWg1Uce81ubBYVXqtJAMrpzn2fOCrJXN4D1Omdjb8m0PFSl8?=
 =?us-ascii?Q?gDBtS95r8Xi7z/SO4lDHDGEZBEmNQZN2RzN8cbulS2AQ4S0r7uEw7sswJs/H?=
 =?us-ascii?Q?hovZXXj8jpQQC/jd8pMTuwun1LI60bEoLgtrTq4S3EzH4v07bFXpJFFeJxcT?=
 =?us-ascii?Q?QihMHXIFtWJ+6+zMODy1cBszqQKpf+8/Xbk8ecNqzvhGiZo6GRZwD6c5iCoQ?=
 =?us-ascii?Q?4x8it/KQq8TUHJM2eLd7lygs/eH0A/lpnmKu3+QFTrUnbi1gOT/b8e3sZAew?=
 =?us-ascii?Q?iUCnncqt/axLF3e4v7rKcDhgIWsC2zQ1LkmkjCyLbOVvqtJ6WtWUeqI1sdw+?=
 =?us-ascii?Q?3oEa4oH/nYprH/UpDSiKV0Khi7xBnXjUAjz9W69bh/AWyQy+cye6vxXRdyMu?=
 =?us-ascii?Q?la61Qj+If+aSGouGrsDQJcGLT43e8hYdoIQJz37v+2Q6u9UB3dpxf9RNkmje?=
 =?us-ascii?Q?yrl9GTfmW1OfYIvPLDmLmnnBfcAn58A5P1geDI3MheM8+Z4q/5A8Opeyab8V?=
 =?us-ascii?Q?X6iPQ1WREYDWCH/l3ysC/+j4GEEjdItSWScUSUCYcKfXPVeptghQYozX6XSQ?=
 =?us-ascii?Q?5qJN1VQ+GYtgyyaWdddRJDAvMBiExD0q+DywuywqVPn8dldQ4g4udJ93M7nl?=
 =?us-ascii?Q?HxnHtBWJljG1crCAjbukf+C2e8/DG/HsSI9RTEwLrQikKnohEb6rFn5NpSkk?=
 =?us-ascii?Q?eru77FZKKashZicgIj5k6L6m85GmFFhsshk3kXs1Vm3hUrgPs+WmeTEok40Y?=
 =?us-ascii?Q?CFCcnraRIyHCqc4b/gP/Auw+r5bRn3zeC5HLCM9ZAh63L+RacV/ZVHEbkUqG?=
 =?us-ascii?Q?kMup+IJLe1ha6I1rv/0aTRE0OFzoE9aRRapHufZp8sDuH4Srwy5VVhA/tjQ5?=
 =?us-ascii?Q?P9J6NjQE5o0a2A/qbZl9hpgFzik2t9Uqo0ZBtvWIJbCh3Wq3ymmp/GhnhpVy?=
 =?us-ascii?Q?UGrhAqwlhryRp6o6VgNcyGHN7agw8d16/DThFOhS4zg49LgWrKgqtWqoQnmC?=
 =?us-ascii?Q?ldnhwyp8UgTpoIxOIExtH3erRv5G/5GPnW8Qt6Su7u5FCFaKjW5nDp30qZCe?=
 =?us-ascii?Q?4mBVoGhMFvdV55PTSfuDKlM/bJHrPivniNZ3FNB3vbF5P9owgUsRpLRNCzzg?=
 =?us-ascii?Q?5BnCX/8rqsgUQkCN0k22CTyL2x2qIIJtnuy/HjTQK6yxPm61nAixUdRncP+2?=
 =?us-ascii?Q?My6WUzDZeL2+kvdPfTV76yM4pgrMvCE79FQsM9QcHBKLtw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4347.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?GlvJTzC9tgIunQuxAYQmxD1ZtTugCCwmGQJfabJfQ5cxcgR0hu1gf60WJcsg?=
 =?us-ascii?Q?DI6RRJqzESbzOOZ+augkCZqSV+cfNZnZPyIMIiUGP0W9HYNubN2tL+ZIoLiG?=
 =?us-ascii?Q?4hTENWa0vSs+OctSdcMlacLABrHZiem7oYzsOtLCOaCAONblaAUgc1hpBF/J?=
 =?us-ascii?Q?7J4CW2ZDJpsonl8ksbbFy8h/JtEemh4HK3JffrK5C+I+Hc5sVF/eq7qPf1HW?=
 =?us-ascii?Q?bKFamkttZKAQbL06DadOekpKhxElYDfizVs7nQ2w9106x2TYhcGwlLWrhTpm?=
 =?us-ascii?Q?kHlxVtKgsAx/KrFmxSQiDY78qKUUZwejO/tmTy84/tueCcs22l6Tp3N6mY//?=
 =?us-ascii?Q?c/7PtmYRPnhQXTT0DeAhYMhwEPDTb/Bbg9nUVeHupB8I+XAWdaJDokl2xWvy?=
 =?us-ascii?Q?rZr7RvqZ9dZsqPlD5DSBPk3gZNKiK9wVs6Nw+NdrPvHHl6CHOijOzrKQhS6b?=
 =?us-ascii?Q?t6/8agGdq5MNaNOOswD6xgDDE9eS8fE7nmHUrvznvef77Dlb/JLvwLDCYyaY?=
 =?us-ascii?Q?2ftx1tIqWTlWjck2kSPAxbO3/MV7ObCf0HNCHZxnRmEVTaXFhgoSE8lH3ZiU?=
 =?us-ascii?Q?T+VyIHsrWr8RDC5gNXOqKSCYdljlFHuL2T1KMWqP8w5cvpBgeJqX+5XIIp0D?=
 =?us-ascii?Q?gPSfbNheFlSW2lUYK1RU73U24U9k5SDWVCKoDZhCH8OpW4bIRReYHVJf1TkU?=
 =?us-ascii?Q?Ml6+WVkKr4CH1z2aX1D1Pd3gEhg33iTKkdpzai+eUdb05Af9fJYA0SOmxFT1?=
 =?us-ascii?Q?V/iLRr8tH7n3JTR5uucb4fwUMyvmpJGJwuLmuvgMoqa+uHfCHKJMvECza3Oq?=
 =?us-ascii?Q?BJLLFDbVplMZVyWXf5LO8eEpOiFqzNyhMj8jdX+oe103jfFyBjMmZK5Ovf6y?=
 =?us-ascii?Q?gWKXq1lzs9/7Rlffj7AdQBL1dBWuiHTblRUFY3a8mzBo9G2mz3SLoSmShpBy?=
 =?us-ascii?Q?zAdQXD7iLY1/HSo74Q017ztx7O/CHWV2Ee3ZjF+EUolB/CKT7xtlTuHC1R6w?=
 =?us-ascii?Q?NDfWCuA+pKQ/Tnsd1kmnXX3TSq+yzjNlOwaig9Livx0ZaH6WpCGZzDiti64m?=
 =?us-ascii?Q?10wiFLnPVZLmmXIbXybmfNdTcqnRZ62piT1UDACulRvHJRomcMwnHQ9EzLF8?=
 =?us-ascii?Q?cT3cRrRXvS/8pt59kadiMjHutbzRzuT/5A0O882659EfSZIZcDFZJxvZEhX7?=
 =?us-ascii?Q?+fDf1sEpHmTkv9HxFTf4NHW1Ow9pAGjig5HQNTVPL6u7g6/8piuWf9OFmNve?=
 =?us-ascii?Q?Lek8EwK0lLFUKiThsA+8YCSPjoo4ShALxmhQu5VTJUg6v0AVpymKVe/LTOOr?=
 =?us-ascii?Q?yv1BAW5QiXwn+Ss0tzNSH+AngeZV74rXbhsoq6aUjlWGA+dyAnW9DupSMjm7?=
 =?us-ascii?Q?8fnmByC6joy9tYlTQZ9d93TRM6xBttM5wEqPdAkq0uNKHigmG5JSf7PIB/Ye?=
 =?us-ascii?Q?AjyTWt4X/TSe7bJ4C2xUqMbw/u+6ctwcvhjf+rb2WAAzQQbLCt+itp28IiAA?=
 =?us-ascii?Q?bUne1fkbvKA7nzqGEi4/YCwCXAR2ppqWOm3wOYZhVt0oPkFCdHlBWmFCZ0Oc?=
 =?us-ascii?Q?g+lDkQHd27WDwIjJ1uVDM+F4OrAaH9yBPESHqp7h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	w0Ws2HOmFotREECYs7BsG683xRf62V/Rx5ZSC55Jp/fuuPUE85mvjEBZqZuY181aX9QyqvqWyPEZqVak1an9fg1qCesUXmJdIjE0At+3ivCtMHWlXWuynPCKaJu1qYLLelNuxP2gOznvcUOY2cwaKaZbhyBx2prRpaFTlU2x2AXjBU1XmojDgslC9tiCZgvkglW9aNt6hcpn976MV8RL2Xf4bbBzQtySR+sOO8lZTYCSJCvfZxmh/2Ik3xIVw3hOUtLQZBnkfskf5c6tzBqbKeqiASCw+DQBwx2CND2P4MiEKpj+WVlndd2RdzHtbgSsDjjM+G0yQWmGeXxHOOEvysyts209hSQE0g7YunBzg0cy1mmNcYkugAXh8erCcfN/7//lTlTTbdyJD42eOAQK0VZ2T+ZO5YVt3SwFGVPFhDYTqIvmo61wVllzbUqUQ9lvpNqa6edOVZQRne1SXj8n0iMisfxEKOY0TwDsY7fXZK6YIiNvbAXKCHDbicU8cjIP6hROez0j6+5NI8AC9B5rIHAKYWNPhrmRM2iegC3fad2OgrtXna4/33wKEp0BT3z7nEy9lBXBB5VJSc8rcKPRUkflnwhQzNgqbOndy4vCRjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4347.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d90741-a8fc-40c3-4030-08dc8150a435
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 09:04:13.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UyFUQQkD84wgMY4rcozXlqDFwjLoL+ttFvnr8t1kgHvbs2INjMotGtaabpbSdVdA3Q1eNGWMRlEJfr4378DfGHak0pCwrnDUHaWBii7BjWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_05,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310066
X-Proofpoint-ORIG-GUID: JUyIcN7ckhg5_oHAXULffIRy-iRuA2ti
X-Proofpoint-GUID: JUyIcN7ckhg5_oHAXULffIRy-iRuA2ti



-----Original Message-----
From: David Sterba <dsterba@suse.cz>=20
Sent: Thursday, May 30, 2024 10:59 PM
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: linux-btrfs@vger.kernel.org; Rajesh Sivaramasubramaniom <rajesh.sivaram=
asubramaniom@oracle.com>; Junxiao Bi <junxiao.bi@oracle.com>; clm@fb.com; j=
osef@toxicpanda.com; dsterba@suse.com
Subject: Re: [RESEND PATCH] btrfs-progs: convert: Add 64 bit block numbers =
support

> On Thu, May 30, 2024 at 05:37:54AM +0000, Srivathsa Dara wrote:
> > In ext4, number of blocks can be greater than 2^32. Therefore, if=20
> > btrfs-convert is used on filesystems greater than or equal to 16TiB=20
> > (Staring from 16TiB, number of blocks overflow 32 bits), it fails to=20
> > convert.
> >=20
> > Example:
> >=20
> > Here, /dev/sdc1 is 16TiB partition intitialized with an ext4 filesystem=
.
> >=20
> > [root@rasivara-arm2 opc]# btrfs-convert -d -p /dev/sdc1 btrfs-convert=20
> > from btrfs-progs v5.15.1
> >=20
> > convert/main.c:1164: do_convert: Assertion `cctx.total_bytes !=3D 0`=20
> > failed, value 0 btrfs-convert(+0xfd04)[0xaaaaba44fd04]
> > btrfs-convert(main+0x258)[0xaaaaba44d278]
> > /lib64/libc.so.6(__libc_start_main+0xdc)[0xffffb962777c]
> > btrfs-convert(+0xd4fc)[0xaaaaba44d4fc]
> > Aborted (core dumped)
> >=20
> > Fix it by considering 64 bit block numbers.
> >=20
> > Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> > ---
> >  convert/source-ext2.c | 6 +++---
> >  convert/source-ext2.h | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/convert/source-ext2.c b/convert/source-ext2.c index=20
> > 2186b252..afa48606 100644
> > --- a/convert/source-ext2.c
> > +++ b/convert/source-ext2.c
> > @@ -288,8 +288,8 @@ error:
> >  	return -1;
> >  }
> > =20
> > -static int ext2_block_iterate_proc(ext2_filsys fs, blk_t *blocknr,
> > -			        e2_blkcnt_t blockcnt, blk_t ref_block,
> > +static int ext2_block_iterate_proc(ext2_filsys fs, blk64_t *blocknr,
> > +			        e2_blkcnt_t blockcnt, blk64_t ref_block,
> >  			        int ref_offset, void *priv_data)  {
> >  	int ret;
> > @@ -323,7 +323,7 @@ static int ext2_create_file_extents(struct btrfs_tr=
ans_handle *trans,
> >  	init_blk_iterate_data(&data, trans, root, btrfs_inode, objectid,
> >  			convert_flags & CONVERT_FLAG_DATACSUM);
> > =20
> > -	err =3D ext2fs_block_iterate2(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY=
,
> > +	err =3D ext2fs_block_iterate3(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY=
,
> >  				    NULL, ext2_block_iterate_proc, &data);
> >  	if (err)
> >  		goto error;
> > diff --git a/convert/source-ext2.h b/convert/source-ext2.h index=20
> > d204aac5..73c39e23 100644
> > --- a/convert/source-ext2.h
> > +++ b/convert/source-ext2.h
> > @@ -46,7 +46,7 @@ struct btrfs_trans_handle;  #define=20
> > ext2fs_get_block_bitmap_range2 ext2fs_get_block_bitmap_range  #define=20
> > ext2fs_inode_data_blocks2 ext2fs_inode_data_blocks  #define=20
> > ext2fs_read_ext_attr2 ext2fs_read_ext_attr
> > -#define ext2fs_blocks_count(s)		((s)->s_blocks_count)
> > +#define ext2fs_blocks_count(s)		((s)->s_blocks_count_hi << 32) | (s)->=
s_blocks_count
>=20
> Looks like there's missing closing )

No, all parenthesis are balanced.

