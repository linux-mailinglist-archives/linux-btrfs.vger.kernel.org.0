Return-Path: <linux-btrfs+bounces-4341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 843308A81F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC752829E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A026F13C9A3;
	Wed, 17 Apr 2024 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YXvDfKQK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RiOg35jx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BED13C80D
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352840; cv=fail; b=ajgMQyYSrij3S3s6O3ycLHt3/9uqy/a9S8MHtWwL4lpgVYr4IPmmJRUw9PsxxrG+eZqxtLZ0QQLc3LDTp8OK1m7bDWwNqhDSP7Bkfar+mcu2pNFAFxYDibCA8Os1C87izXcjdA0B21R0vjGQwqP1NuxkBarXpZMhBYt9iCKB3OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352840; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jINAsG6Lr2hY2FrN8gMbncGYZKjxkgao6RFchUiT4HrKIczr85gQhDcopzz5b6H2+A429yuZ9/OG7epFMJMuTNNFnCBZicID7zCiUlsN6uH2MbUWOf54huD7oI2OEewnNUyJsxYVQlGJ1MpxmljxiXa4QeI+Jc73NDuYuNKiwzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YXvDfKQK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RiOg35jx; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713352838; x=1744888838;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=YXvDfKQKVYyPKxtxo0ZGD7Hye215Ytyv1CUR6eUufKAS6g2ug9ciuIgW
   +crfFI6nVX94teU8LHTQ9jhBqIeMmmrznFPAsHh9eGitb1Q5iLWqoF60i
   DzTCelbaCQgEkh69xOH5Q92muJdN2UzQto1EqM2GWIUcOJuPxEfBvwJsK
   /HAW/HfIIF5wPW4mZdzvfaPdZj4jq4GB84I02d1i5S7cU03P6uepSYl6y
   FFWb7CClflbdWTaFNkHcwP1KJGfI6RsdTJfGqdDh0Sal6lhtbLyfDC2hZ
   JuhHdR1QrnEbX56Nvfe+CicZmo9SYGx3aW8BNmeZg/6R4V3fjMvHjMvpm
   Q==;
X-CSE-ConnectionGUID: OB3rNtNQTm2Mfu6/4Mwhog==
X-CSE-MsgGUID: ZOsO1NMfTiq/w6BPVsGXhA==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14216119"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 19:20:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+B6P3QmEN1iKWMitWpD+o5JpsL+1pN2T6bzNxu2w9HS0TQVBR2JSs9r2mfM4eqe+stvD8vKFVYOh1xsqk6k1OVlUtdOU/EpGuqkl1FmFxGPuBs/4VsCw9u31KBe5Td0mbNhS5HX1GOsNMeXABOmPBTiQkf44iBhtd54Y8m8+06JwIDq6qCBhkGZhcMVOug8PfzegZkML8OUgg4yB+OD69G+p7S7wT3DZOXzQRU1coy5tVGNNTbmb6C3Xe06CoxWCJygBjjWpTbYgfHjp/mhCzO/nWsiJMvtg8Mtt2aVQ8WWoOic9kEFMnyBWIAIMTckgKRAGVpLRPn4teqLUFEj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=bPCnzO2pEgpdHR9a7zNciuhKVw3VAL0rRvxTBMVou15RPKdrB83assOOXqOUNPnx2iKttdb/9Rg8d2/kNQtlWQM/PZtOhEaL7m1AJnChXQ3B59WGt19LPlXvU2KKLP6uSeLLWmWL9eGaQUqL24jztn0hC8iKyNOeDHpfHyECVQb8aB5VDB2WGPXntxT7juqbqhWuAJjTkuB7DbN6JB+hOnQrQxmIQxJXl4zoNe5QkneQfmTC2Vk75th4A9qAP/MQTNBh9s1bDrQfF790LhuPxb9ONXJ+b4zQVXGyedDJOuZc8oZvV07re0uo5/4o91XC3DirBUfOejiBS380rsj1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=RiOg35jxilbmKBJpwce7eX/IUxMwDRmv0sU0ahKe0BrsBzkHHS/KkMv0rKTVufzNX+2DNtaEh4I762hdnphAHU2DgyOa88Xg77FHURIltCLga+mIVuYFuxA/oi8GoNFRBJFBJCetP84V5QA9pB2A2GXgWK13SzDsBUepBkaBft8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8107.namprd04.prod.outlook.com (2603:10b6:208:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 11:20:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 11:20:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 10/10] btrfs: add tracepoints for extent map shrinker
 events
Thread-Topic: [PATCH v3 10/10] btrfs: add tracepoints for extent map shrinker
 events
Thread-Index: AQHaj/9CtjKhjY6tzUay8DHVImT/47FsUoKA
Date: Wed, 17 Apr 2024 11:20:30 +0000
Message-ID: <e2c939c7-0f31-4ba8-9984-df693ba10176@wdc.com>
References: <cover.1713267925.git.fdmanana@suse.com>
 <1f936e6053adef193d57f9ca87c68797c88fae1e.1713267925.git.fdmanana@suse.com>
In-Reply-To:
 <1f936e6053adef193d57f9ca87c68797c88fae1e.1713267925.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8107:EE_
x-ms-office365-filtering-correlation-id: d855ddaa-3854-4f5a-1b99-08dc5ed063db
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WbqlnSmspc1bryGF4LM2p+p+HJmhznN5njXnpP2uDR2xG+8hn5rbShx3b89z1NvWEe7+h8z2k8Vq4+/vQ/1TKr/KBv2GaUKVKWfZ5B3goFuvHTTQebrzloIDnE5LEWTOxzu8EhPbnK3LEq/wWzLxXgqmaQhpBBNJI6KAYuyYGA/PRjs2nkC+1M1Fjdp02W956UAHiqwqtbIz4l9IYU4alZ8tTnVt5TW/vdXOk6rZRIsWwVkMVE+GZuSXypyz9maf6bR1r3l778Q1dDj1AeM1SEG4J69wZOioCBNMPItIfNMvdfaufX76TSLfiylpMfgSOfrobEmYaDUHoNjYBcojMYDTITGSmK3GS1MZtORk8As5SHiYTUZEC9364MUIFC4aGzKG6sBqsmTZpf2zM0Xcvq5fafcYa2sl90hDZpOWs3cINCERxPkjRUW9DglTlHkbG/mGdevROdl8cDtVS2ObA9out0Rk43Sjba/ESsbNtl+sSGNW/Kjslzg03ZHMuo6rLJ28irL1iJc5psgBEB6SBZ6VddsI/X62RC6uMzfzzkk8svhnhSyMzkvesLcz+rqkMJpvpJbSNImvt7TMe8hzPW+W71QVPTGpUDNCi23LGBeRcnwyFKJoN8J/jF8Akk4z8J4VCLFXl+F9AeSkVSH2ZPlwdYnzuXywH5cWHe9RCbOR03F8Yz88b6h7Me65m/brbJ9HqvvixIsoxe+P4IFLHOlw4xNUgoqT/pi0a8/Cm8M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFprYUptbysrd0JoeVBVZlhvUGN6d1NSWVk4aFBlRG5XekRLZWJjbVo3SGNS?=
 =?utf-8?B?Z2x1bjJNcHVxOUtpbTJCNFE3RDNVNGsrc1J2WFN5eEVYOEI0ejlxR0F3NmR0?=
 =?utf-8?B?QVpQbmpDY3VRNk5XWmZaVlMwUXZ3S3RscHRaREFCN1hIM1I2cHNvSStNUXo4?=
 =?utf-8?B?WDZMS3FtRkpCN1c5dUUzekxXZXFYVWx0bDZwYm1pZHJtemgwa0lxN1l3VHNK?=
 =?utf-8?B?QmVDcDJrY0NuMHhpaWNvNzNPY1pHZWl6OTFBUVY5Q0JQa0F5RmVEV3F6M3RR?=
 =?utf-8?B?MWJ1bDQ3VVFSYlpqdzIxVmdIMU84ZHU4UjhrWEpDblB1eGlnS3hZalJUcXIv?=
 =?utf-8?B?SGlPb2dEOS9ZVHh4Q0Znb0Q0MFVCYTNieUVHbXRBQjlLN3FIM3hSL0l2aGRn?=
 =?utf-8?B?d2FNbEFQNkxlcC9sL1J6ZHovNWlGVTE4N0RubHJQVmsyMFJqVGpJN1B5K0hJ?=
 =?utf-8?B?ZG1QRTQxTTg5b0ZVTkQ2SnFobzdsWGpxU2Q2TzFGTml4TTFFVi9aQ21mKzk0?=
 =?utf-8?B?VWtOMVhHYjFvUWNJN1oxV2taaW5rVGxYZ1NEbUxzRDNLS29CTGE5RWV0all1?=
 =?utf-8?B?cDhQcTBZc0VXWXhyeit4Y044SVBydmpNVWVQaWpFeXpsMmw0Um9OcnZ5Yk9l?=
 =?utf-8?B?RmRMdElTVlRhdjZHNUdRYkEyV1gyOFhNUzVBUVRwaUErcW0vcjN6YlQzcENK?=
 =?utf-8?B?N213eVk0bGdzU0pTeVRpaC9xVEVWdHNYdHpQQkVpRWtmU0lVdDdwVkdUeWJV?=
 =?utf-8?B?QldoUE5LQVZqTEZXU1Z4T1c4ais2a1p0YmcvRCtMQ2Z1YzJZWE9HclhYZ3Jj?=
 =?utf-8?B?K3ZGR1g4ZSswczF0M1RHS1ZCNUFrYWJvYXVoWjJGalkxaFRudzZuQmdlZVE0?=
 =?utf-8?B?YUhRSU9hdnh3eXFnVHBMR2V6NjNVaXQ3clhDbGFsdVNrQXlRQzBteW9mcFB3?=
 =?utf-8?B?MWZNR1U2b3owVmw5M1JweWNmeGJZaklmNlU4dmk5MFVYRVNkanJCMDFHdmRs?=
 =?utf-8?B?dyt3WkNVRk90bUZEZHlGMDMxMWQyeVhrMXhuR2U0NFJrak1CUGxjRVoweGdE?=
 =?utf-8?B?MFhHTXN0dzlha0d4Q0ZvMWlkNHVCMll6MWxBa0pVUFd3SUlVWWdGb3dQSENL?=
 =?utf-8?B?SndST2kwdXBLRlhIQ2VvQU1KTFJSWnVzTVpud09YaE9POUFqY2hjb1lQcFUy?=
 =?utf-8?B?NktpK3ZqZWd0d2xZbUsyNzdQQ2F2WWo4UkpMSXBDcE8yKy9STHB3NGk2Q29I?=
 =?utf-8?B?dlVzMTcrckNSVHJaQVMyb29KUU03Sm15dUtwMkoxcGxES0RSVTlIVm9VTDJB?=
 =?utf-8?B?UDNqWVV0eHhmaDZaVTl1VXBWMEdIQTlyYnBZVDZHNkRvNFhoQWdsV2dZSDBo?=
 =?utf-8?B?aFVNa1ZxOFJmcEFVRVJzSjE5cUxoRVVVNWxtejhMQldVWTAvMTZMeWdBMXpV?=
 =?utf-8?B?dnRwSnQxSUsvZEhOVlFhd090KzdseFRvKzEvdlppdEkyYWdTcUYveDlnVnc4?=
 =?utf-8?B?TTlLRUwvK2s1QzJZK3Rmdk1QQlVPUjE0WDlEcWthanJNSDJEa2NSOHBzLzhU?=
 =?utf-8?B?UnhwN2hKK0Q1bFJWZ0xVSWlSQTBhV2s5b0U1YmUydGUyWGlQQ3kxa2FGeTQ5?=
 =?utf-8?B?VGFHSEhhWjNQSnpHMEt0YXlDb3VjYlJvTHAxeUxNZ3JRZzRjSTk1ZFZXdWI1?=
 =?utf-8?B?ejUrc3FHRVJrelJIUDJIcTNEeDhBV1NkcUdZOStwVnY2L3JYKzBlQURidmM0?=
 =?utf-8?B?S2JFOC9mRkxZVzRJK3dRQW4wc29UQklvK1VpYmVsUnNHOXZtV0FVT3RwVW1U?=
 =?utf-8?B?NkRVTllZNDRUSVIrbXhTOXd5SUkzNU40dXlEaUMyUHVpQ2poKytINm1Jd0I0?=
 =?utf-8?B?OVd2Zmg2RGZCV05EVHNpMjVQWjZGYXZ0SVoyRTBGRE5ETGUyN0FIbSt3MTVE?=
 =?utf-8?B?MmVZWGpkaExiYXVDVi9wMER5RzYxYVgrUk53RkdxTFlteWErM25HcmdvcGR0?=
 =?utf-8?B?dXJwTXpnaVhhZm4yUVRvek1SWXY3a3AwZjBnNjBQWGRyVkpLdXJhaHB1ZFQv?=
 =?utf-8?B?d01wclpPbVE3bkNub0NyY3hCbGx6dUNYV05paG01dWRZY3NaS2JYTlNNY1o1?=
 =?utf-8?B?N0Y3bWJQd0IvQjhRWjN4R05OQ1B3c0g0eWp0c2NaMGZha0Z5bUxuQ0hINktE?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBEA062A45C30B48A9498D46B0ED1E94@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fsXDAH8DNjyCVF79jzQLULm6/b4Vc0ZebmQzrxKRs8Z8V+2tPJ1HMEtWyPICj37PoORuXjzXM4vOM5/0t+t32gDOgsCr0FDpwqQlQ/F03BEW0lBmcrW8hg/N7DEa/2Ca/P8doSk2VKoC/OFm4OVP6ICtYqgxpCqIcMJoDtsqRbPmAqi8pu/LHuMbjW9IlhLyfZzskjq/E+JWEwpiag/N0uYVUL05QfOVMSCJ2mj44fgmyxj+ub5XfNeU6nH/w/GwPw3zUocjKiHV4HzSxJrJhadUR/vBhv0ij3Qk6c82f9D46gNEiLQJfEhxLS5fjtOdCtMPVJ4B1H2g1HGEU9wID9Cx7oYhOO0EFF9mkoe+/rpSmv7FEnNBn1pJqi+Hr5OJRhRO3QVXPxVn54UuwxES7XOxa8iDSj2uphq+cluBT70bYL+bclskv9pscaqmPgHb1QNGhPdQNOdeqglnIs4Qd1y/cXTAytXY3FqAQb8CZAhJU14oJfgHkXYn1zgdYPH9BZLiX9pgZa07BZag75JCY2g7vLSCVw7kmYQOb55cDJTtdbGCLdXcAwBGkQUMUeIoebNZcxj1VqVArZQatDDaW35/gLoq6giz1PRJ0lafTNw3z3Tp12XyC7uGLe1CISxe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d855ddaa-3854-4f5a-1b99-08dc5ed063db
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 11:20:30.0899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QEUFdi6TglXAH2ab3izepbSg2T0RRAY6txcqhduzK70qz+qlzIXybwoHmKHKejB4AEOxymT/02S3hcmaBgueqit4QelwUfdOyCmPvnC/IIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8107

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

