Return-Path: <linux-btrfs+bounces-2199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D04E84C4CA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 07:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C883F2894E0
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 06:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACAB22323;
	Wed,  7 Feb 2024 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="A47gPTIT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF0521115;
	Wed,  7 Feb 2024 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286204; cv=fail; b=swdgRCX16E9xbCbpC6WMzYsEUVzcTRNyXWLyUn8tjd0AOLyBt2gns+zJ7arhIcMa+GXB/yvol557ZavEHgj4BmTRl4AhxRS7bKV56Ip+/QgyifgYFq6wjr7+d/tltXRBqAN/d+b+nFes+9oibRJafKK7W1ntWE3WD6gMk+IDzI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286204; c=relaxed/simple;
	bh=x+30uNKHMnnMLMI3ppsuw31Wtd6tGEChuDxBok3SjVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GKGgOFXwlIyXzJF0oxyXzCHb0l/OEAWd8//BSqYi19Eiov4o3MtBFSBqwNzof/xJbXWRDBxfIUpRDB0uI2O6o1eDpLF9caO693LiSTtALEP6SJjADIwFCWlnY3LYC6zm1KHer1/a/nBusmHOaIscckLgcMfnQTiMpu9Gx/w22Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=A47gPTIT; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1707286201; x=1738822201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x+30uNKHMnnMLMI3ppsuw31Wtd6tGEChuDxBok3SjVQ=;
  b=A47gPTIT7JmVcFNZISfXI9AVp8fjX3GTCtAk222Z3fYNsuMwCUWW4a/i
   t1JV+59mnFZko8+g4nY4npanbEhXIQGg3Z1Expd7zm6zniTAHMVesdSlk
   KCzW+iDyGP/levXnp+SlNQsUaZlS3tVpPJdqrMs8Ll82O5EhbM6cJcGFA
   IOKVCgygPVD5bp4VWTDQ/4fG8Z29cmxZcbJaNAvs2w1HyIWOqLq9GmfHW
   LkvSxa7BPmoGBrj1erRqzb3JHF+2Bxald+D5oi5e4fIFpCaIqiNmH17Jq
   IIw+9SnaENrMvCxJKfngeKMkVz0EZLrTEkCPQmZ0qCBEZO0+EkTCYCLUO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="110660775"
X-IronPort-AV: E=Sophos;i="6.05,250,1701097200"; 
   d="scan'208";a="110660775"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 15:08:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6e0hriNobYbV2pX/942JZXO0YMy+bxMblBcRGi4uLoeQFhsF9MkVSB2c2HqsTInHHcpxatL4Hj6KmepQJUDnX0I08U9h30HjK5nbuA+5P6/qIkHvS8gyggVyifRTP+QgYImgO4h2yIL/DeiS5zuv0DFd5nL9mgTNmASLRxO42dekUi9CJDuavmeyGYcsnOX857PR64JcGHJJEdvMNQzNaxJ0yquBCsq94993vUxHlh0yMEzxkPb11iNJx6CFiNV1nihsLlzABej3wAEIV34qh4T7PYCaHihvJVUi2z3BRQMNfL/cfBgcqCOWmb+ZBpoAPnH6rWyo22c9Wm/1csmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+30uNKHMnnMLMI3ppsuw31Wtd6tGEChuDxBok3SjVQ=;
 b=G7fvvjMBeKpaqenNC98Rs647rajNGpdbBHcJOjKe/7bmHAcgqA8vvvUyY9HxV6WlRNY9ORL9aLNdPA4Q00HFuQYuSDHt2Zlu0lOilCipbXbFXROlCaG92dFA/mopqVoZHi7bcDOmNWm+aPc434Kn+vezNF8qKbd1ZhY2Rr71GqC+gOX36OjDa3p72JMlGvTO48aRD9iqjP4SBp2UBFZEBB7Fn8HR90pDG4fMnJjVnceXIIejCaJ726O1IeOFvA35zWoEyYnEhzsiS8SjZZnoAH3O+TRFpfA7QuGwB4ds9oGcDw7v8dlNO1Je0ctAkmPDQsTbV0XlRpotqYjJ1H12nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (2603:1096:403:2::22)
 by OS3PR01MB8398.jpnprd01.prod.outlook.com (2603:1096:604:191::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 06:08:44 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::a9eb:1475:e04a:3271]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::a9eb:1475:e04a:3271%6]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 06:08:44 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Zorro Lang <zlang@redhat.com>, David Sterba <dsterba@suse.cz>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] t_snapshot_deleted_subvolume: add check for
 BTRFS_IOC_SNAP_DESTROY_V2
Thread-Topic: [PATCH v2] t_snapshot_deleted_subvolume: add check for
 BTRFS_IOC_SNAP_DESTROY_V2
Thread-Index:
 AQHaVXqNcCeL1XNwmE6JJgZI6dBvc7D76r+AgAEzm4CAAB9GgIAAGU6AgAAEFoCAAB1YAIAA9OCA
Date: Wed, 7 Feb 2024 06:08:44 +0000
Message-ID: <3b2bd3e2-be39-43f7-b541-5d70a06b0db7@fujitsu.com>
References: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>
 <20240205154907.GH355@twin.jikos.cz>
 <20240206101005.u2mrxlg4pg3cdoxq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240206120201.GL355@twin.jikos.cz>
 <20240206133235.rizvxggjnsv2ppcf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240206134713.GO355@twin.jikos.cz>
 <20240206153214.kskmv2ug7b7rmtdq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20240206153214.kskmv2ug7b7rmtdq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1578:EE_|OS3PR01MB8398:EE_
x-ms-office365-filtering-correlation-id: b0d51bb0-9d0e-4a74-c58c-08dc27a33da8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qdwzGncC2wnI+ZULAAguL4+iXyQb3cjDHz5vAkWlN5leaf4AkrCgeFczNeHnXxJH5f+hL0F3I/EptsEzW6Wx5t1jrHo+5X8VnRGyR+5iPp1zsJk0Lz/jLBqUP2Ww0YLcF6vvrR+f3a7Fkq5F9lZQh54yVKNjyRM5g/8vijhNES+kzvKEOkP//Gm/v+9XaC7uRSgg9udEy/lhVv2qBZQLJAN0QxubhdukGuxfNBtgJ3LCV3DCTEXWFSIBNKeH3OjcoMiOERGgwD8FV75Lc5rcftvITjkKdsxRTjsf4MR+MH8sTIbgWq2VkwfVB+tLjiJnqb6gIFpBA3tvUqqv0qX3SIHjo4ruPt5CAQJnQpmdmGbJ+DYU3aQZkyv8VTIRYuegNynfxEwLwOPSYgD2pOYP5IozNWBNeu8TeB3E0Z+LAgYShM3LopxZgZtIQI2yRTSaSSCYMjhwYirj9L+wfFFjS3EQebjhZEeDHrUBH8pee3YNxl5QU3UqOMhUvV/2zD8pA7vQCI5WzZgLCxU4YgNmxObsEyRx8upabpErmNhbe+vHgK1PuyvJQr6iEgwM/jb4/NiH9Vp5KAFhKNUebBFpPapii4S34o7yCbwixRGbhbfgtd58DGGx3Cm5N4b5ur49VYLXMHNCpinCbuS9uZK67Ursxd0LW5wT2VN/B3qb3VA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1578.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(1590799021)(186009)(451199024)(64100799003)(1800799012)(38100700002)(82960400001)(31686004)(5660300002)(1580799018)(122000001)(41300700001)(478600001)(6486002)(110136005)(85182001)(6512007)(966005)(36756003)(2906002)(66446008)(54906003)(64756008)(66476007)(66556008)(76116006)(316002)(38070700009)(66946007)(83380400001)(71200400001)(86362001)(26005)(6506007)(2616005)(8936002)(4326008)(8676002)(31696002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWEwQW9XRUw5VGI1amZHOFU0UTdkaFlmZ0pDQUxFYlRURU5vVUM1dFQ3eEFJ?=
 =?utf-8?B?Q0IrTERiOE9Cc3VYR2lVR05tY2RoSmpyeWhqdVBOYldKVVRHTXZSTW1mZzlx?=
 =?utf-8?B?VDcrcy9mSFM0Nng0ODBnMGxVT2dlNklrQmdNSlVEeTlHZkFnckswYk8vcWZJ?=
 =?utf-8?B?WjEwVG02TVYyN29VbmNHeGlsOE1ZV2hXT09JVWFZOXBaUzRYQVU4VEFyN0FB?=
 =?utf-8?B?YjYxcjUwREorMWJUd0ptbW5WMjRnQ1NmQlBhZDhWN3NrbVh3WE1KUFZDNGlV?=
 =?utf-8?B?UHJPd2lNZnl3K0djc2FSazlOREJMT0J1SmFVOWx3NTIyOStFZEVaZ2x6TFBE?=
 =?utf-8?B?WTZSY3lodHRCYm9JemJ1ZkU2QWJXaHliZVczYkQrMW45RUgwUFRJR3pwTTJG?=
 =?utf-8?B?djJlanhyeFBQSzJNN2ZEN3pQMEVtLzZwMVU3eEtQZ3Y4dWZNd3g2ejhxTnVz?=
 =?utf-8?B?TzU4d1psaStXYzE4RkVpQndOYTdHdllOUG5mTS9iclUrNmd1YUMzMjRYQkdR?=
 =?utf-8?B?WGc5YkVUUnBpZE10dGpFbWJSR1VSbE80Y2lCeFRGODBNaXZRejFSMXNyR1Zi?=
 =?utf-8?B?MGQ5UytYV09DNUZPK21Ra1p6ajhVT2Y2TzMrQnNQQ2VmemthMUdFRGNwTUla?=
 =?utf-8?B?OEVQV2VjcUVmbE4vc2NVM1Y2NFlLUGIvSExKVDVQTWdJNmVJeDRHVmNXRWdF?=
 =?utf-8?B?S0FlcDQ2VmdmL3NHV21yNkJZOHdycVFoYituaFlUK2FlcmJ5cVI4Q29reGZN?=
 =?utf-8?B?bmJCbVFQOUtVemtsR2t3NnZtdVVsa1drM1JJb2hIMWRqREZSV1lna1pvWHlI?=
 =?utf-8?B?ckd3ditiWkF4am9SRWQwRExKQjVhKzdnOCtQdFZqOXNvWC9KNmlvMG96WVR2?=
 =?utf-8?B?b3ovajZkemRXRmhKZXErR0l6U1dpSXdIeVliZUEyK3BzYVdHbGdjVlNJMGNn?=
 =?utf-8?B?UURwVW1zZHpBZ2J4dUlWNVFmWVRLc1hXYVAybk52WXlwMFFoTUVBWE9PQTJY?=
 =?utf-8?B?aWMvL0JpUm9Zd0NyWDFEQzRyZVJtNjdJNFVxaHA4ejRTd2RvUjRJLzNNMU1Z?=
 =?utf-8?B?eitPelVjckxHYXJOalo4MkZtY0NsOS9zQ2dtTDA0NnZVa2w1dWIrTXRHVFJ2?=
 =?utf-8?B?L1NaVUlRQlZWZVBFQ0xvaGJzTUpkWjh4UExhaDluM21JZ1FLTU9HaUlMbEUx?=
 =?utf-8?B?MzFtU01OWjBGYWNENnNxT2xtNDZYdTFwWW1pL3YxbTFGT0pubmpaQ3Z5WkZN?=
 =?utf-8?B?Z3FUa1drMGhjc2p0ZnNQZEhEN0tPSU51NUF1dUxLZ1VacmVHc3AvQ2pNc0Vl?=
 =?utf-8?B?RHJzUUFsV2UzV0ZScEhWdVQ0TDNndFZ6L2dubVZFWVh1UlFRTzFxY0IwaTBu?=
 =?utf-8?B?V294NEFyWFZmVjlNNVJaM0pFWFA5dTdTN1ZYQ0FSSWFUMCthYnR0TVZNSXJM?=
 =?utf-8?B?U3JKNm0xUFdVQWMyNDBDQ1ljc21FdThRSHI3REhoY2tYdzZFWVhWRlQxSGpm?=
 =?utf-8?B?SUxqS3NEQ3Jtc05GdS8rOVFyN2xZOTRvM0hBenJ2cXU1QVhWZ1N0VTJOemlp?=
 =?utf-8?B?TENidG1uMjhaWVlzVDZ1SThXcVlzcXhWOVlMRFFGNS9LNk5FSVpHWGI5bzF1?=
 =?utf-8?B?UDBZSnpqd2IwWEQ4bGxhcDRKVGpTWngrQzZzVGRLNzl6cnFLcHZGQmoyUHk0?=
 =?utf-8?B?YWFYUGlGbFZFZjRWQk41R09FMTgwaEU3YnhDVGF3eDA5ckNja1Nwd0FhTjM3?=
 =?utf-8?B?TmVRYTFXeDBUSHlQM212OHlpQ0p4RGg3UzlGNW5obXpRZjExdzllalcxUktx?=
 =?utf-8?B?UjFGcDZqdm9UWlB2YUVIK0hrYkVlemNpSEhOQzJZVDJ4OW5oVlRYOHd5VHUr?=
 =?utf-8?B?VjgwL2NSVDh5VW8xWk1GdW1EaFBuRS9EZldmKzhSQlkzaUo5dUNGOGRBUWhi?=
 =?utf-8?B?dm5ybXQvUCt4MHlQWlNRMFhPL0JES2MrbWREa2ZxdXh0QVpGOFVRRXpPSjdP?=
 =?utf-8?B?eUU2amJKYkR1L1pKem1GcXJZM3J3amRWQm1QZnhaNFdqQkwvYUpmWWlDZ2xp?=
 =?utf-8?B?d2d0bzQ2ZVJ0K2U0cXh4V3I5M1JMZFErT1dMdENyNldFbFVEWElaSkJhQVpR?=
 =?utf-8?B?ZWFsd0ZwN2xXVzh3ZEJRYWNWZVEzTzlaMS9qeVNMQlVPTFRaa2NObWlBM3Vr?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8C2A84139CC1944929120685F129C85@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/YBYPdXjqJsH7rTI1VTeB7jx87zekVHoaDj4hI31tjQvqDt0GgLC77Z78CasXALj2VFGWscySabee1IVvr9NuQ6Lq7wB+e6jnXKrOy7IgdZSh8BMQESzWzePHMDFknunU0oQ76eZLGWB6B6SlWCazfWXGbTdOeWuDzIhsvZ/LUJ3d8XEr5a7gW4CjIdQpYFsJkXYuLnb4zQWSsbGYLEDrZf0gApTQuIduJNVyk8jSyxqizH3SFAKa4IBhXDEocPsf/jfI2YLBrf9Z+kS6bLnf97lM6VwDUrlVwyfO7QI4vxkvB8sfOp18RvazmHs+JFUkPmPwS7sm6otBvx7irv3D/vbV223L4Q7J7lOuZGeS1kC2i9aP0VuDE3tFniBHitbOWe+Jy4y+mHIELCToxblOSfm7ipe5X2Nbw5nx60PD8L0OJAeE3ymYRSHldkxyRkpKKcfEjNhiddsB+lSyn5fa1+up1RtQfEj81wC18SiwonnNNYd73LtZLUkNcFQhRPZxhmqdQz9Qqt/5bG2u03/0Pu39yNcyi6yWJ3xcgz0E8riPOzQ3fdhvtSOiLKUPX3SPsfmhdcf5dKQic7ixviSj0649hWmLKdyHlqrpYGb7BIghRHLvwatJ5jPFfqiGKOf
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1578.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d51bb0-9d0e-4a74-c58c-08dc27a33da8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 06:08:44.6997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ykPpDuYVkkXalL6CkAsjeiIVmnUSQOIeXC8CaHHF6SXEDV9CrA+aL47Ea20Ok5FZ2WCB+/QGqVlCvzPJgrNi/s98tSkAzMcuuOZqu/Vyf4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8398

DQo+IE9uIFR1ZSwgRmViIDA2LCAyMDI0IGF0IDAyOjQ3OjEzUE0gKzAxMDAsIERhdmlkIFN0ZXJi
YSB3cm90ZToNCj4+IE9uIFR1ZSwgRmViIDA2LCAyMDI0IGF0IDA5OjMyOjM1UE0gKzA4MDAsIFpv
cnJvIExhbmcgd3JvdGU6DQo+Pj4gT24gVHVlLCBGZWIgMDYsIDIwMjQgYXQgMDE6MDI6MDFQTSAr
MDEwMCwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPj4+PiBPbiBUdWUsIEZlYiAwNiwgMjAyNCBhdCAw
NjoxMDowNVBNICswODAwLCBab3JybyBMYW5nIHdyb3RlOg0KPj4+Pj4gT24gTW9uLCBGZWIgMDUs
IDIwMjQgYXQgMDQ6NDk6MDdQTSArMDEwMCwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPj4+Pj4+IE9u
IFdlZCwgSmFuIDMxLCAyMDI0IGF0IDExOjIzOjQ4UE0gLTA1MDAsIFlhbmcgWHUgd3JvdGU6DQo+
Pj4+Pj4+IEBAIC0yMCwxMSArMjAsNiBAQA0KPj4+Pj4+PiAgICNkZWZpbmUgQlRSRlNfSU9DVExf
TUFHSUMgMHg5NA0KPj4+Pj4+PiAgICNlbmRpZg0KPj4+Pj4+PiAgIA0KPj4+Pj4+PiAtI2lmbmRl
ZiBCVFJGU19JT0NfU05BUF9ERVNUUk9ZX1YyDQo+Pj4+Pj4+IC0jZGVmaW5lIEJUUkZTX0lPQ19T
TkFQX0RFU1RST1lfVjIgXA0KPj4+Pj4+PiAtCV9JT1coQlRSRlNfSU9DVExfTUFHSUMsIDYzLCBz
dHJ1Y3QgYnRyZnNfaW9jdGxfdm9sX2FyZ3NfdjIpDQo+Pj4+Pj4+IC0jZW5kaWYNCj4+Pj4+Pj4g
LQ0KPj4+Pj4+PiAgICNpZm5kZWYgQlRSRlNfSU9DX1NOQVBfQ1JFQVRFX1YyDQo+Pj4+Pj4+ICAg
I2RlZmluZSBCVFJGU19JT0NfU05BUF9DUkVBVEVfVjIgXA0KPj4+Pj4+PiAgIAlfSU9XKEJUUkZT
X0lPQ1RMX01BR0lDLCAyMywgc3RydWN0IGJ0cmZzX2lvY3RsX3ZvbF9hcmdzX3YyKQ0KPj4+Pj4+
PiBAQCAtNTgsNiArNTMsMTEgQEAgc3RydWN0IGJ0cmZzX2lvY3RsX3ZvbF9hcmdzX3YyIHsNCj4+
Pj4+Pj4gICB9Ow0KPj4+Pj4+PiAgICNlbmRpZg0KPj4+Pj4+PiAgIA0KPj4+Pj4+PiArI2lmICFI
QVZFX0RFQ0xfQlRSRlNfSU9DX1NOQVBfREVTVFJPWV9WMg0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyBp
cyByaWdodCBmb3IgQUNfQ0hFQ0tfREVDTFMuIE90aGVyIG1hY3JvcyBsaWtlIEFDX0NIRUNLX0hF
QURFUlMgZG8NCj4+Pj4+PiBub3QgZGVmaW5lIHRoZSBIQVZFXy4uLiBpbiBjYXNlIGl0J3Mgbm90
IGZvdW5kIHNvIHRoZSAjaWYgIUhBVkVfLi4uDQo+Pj4+Pj4gd291bGQgYmUgd3JvbmcuIFNsaWdo
dGx5IGNvbmZ1c2luZy4NCj4+Pj4+DQo+Pj4+PiBXb24ndCBBQ19DSEVDS19IRUFERVJTIGRlZmlu
ZSB0aGUgSEFWRV8uLi4gPyBCdXQgaG93IGRvIHdlIGdldCB0aGUgLi4uDQo+Pj4+Pg0KPj4+Pj4g
ICAgLyogRGVmaW5lIHRvIDEgaWYgeW91IGhhdmUgdGhlIDxsaW51eC9mYWxsb2MuaD4gaGVhZGVy
IGZpbGUuICovDQo+Pj4+PiAgICAjZGVmaW5lIEhBVkVfTElOVVhfRkFMTE9DX0ggMQ0KPj4+Pj4N
Cj4+Pj4+IGluIGluY2x1ZGUvY29uZmlnLmggZmlsZT8NCj4+Pj4NCj4+Pj4gWWVzIHRoZSBIQVZF
XyBtYWNyb3MgYXJlIGRlZmluZWQsIGp1c3QgdGhhdCBpdCBhY3R1YWxseSBhbHNvIGRlZmluZXMN
Cj4+Pj4NCj4+Pj4gI2RlZmluZSBIQVZFX0xJTlVYX0ZBTExPQ19IIDANCj4+Pg0KPj4+IE9oIEkg
ZGlkbid0IGZpbmQgdGhhdCBpbiBteSBsb2NhbCBmc3Rlc3RzIGNvZGUgKGhhcyBiZWVuIGJ1aWx0
KSwgSSBnb3QNCj4+PiBzb21ldGhpbmcgbGlrZXMgdGhpcyBpbiBpbmNsdWRlL2NvbmZpZy5oIChm
b3IgZGVmaW5lZCBvciB1bi1kZWZpbmVkKToNCj4+Pg0KPj4+ICAgIC8qIERlZmluZSB0byAxIGlm
IHlvdSBoYXZlIHRoZSA8Y2lmcy9pb2N0bC5oPiBoZWFkZXIgZmlsZS4gKi8NCj4+PiAgICAvKiAj
dW5kZWYgSEFWRV9DSUZTX0lPQ1RMX0ggKi8NCj4+Pg0KPj4+ICAgIC8qIERlZmluZSB0byAxIGlm
IHlvdSBoYXZlIHRoZSBkZWNsYXJhdGlvbiBvZiBgQlRSRlNfSU9DX1NOQVBfREVTVFJPWV9WMics
IGFuZA0KPj4+ICAgICAgIHRvIDAgaWYgeW91IGRvbid0LiAqLw0KPj4+ICAgICNkZWZpbmUgSEFW
RV9ERUNMX0JUUkZTX0lPQ19TTkFQX0RFU1RST1lfVjIgMQ0KPj4+DQo+Pj4+DQo+Pj4+IGlmIG5v
dCBmb3VuZCwgdW5saWtlIG90aGVyIG1hY3JvcyByZXN1bHQgaW4NCj4+Pj4NCj4+Pj4gLyogI3Vu
ZGVmIEhBVkVfU09NRV9GVU5DVElPTiAqLw0KPj4+Pg0KPj4+PiBXaGF0IHlvdSBkaWQgd2lsbCB3
b3JrLCB0aGUgaW5jb25zaXN0ZW5jeSBpcyBpbiB0aGUgYXV0b2NvbmYgbWFjcm9zLg0KPj4+DQo+
Pj4gQnV0IEknbSBub3QgZmFtaWxhciB3aXRoIHRoZXNlIEFDX0NIRUNLIHRoaW5nczopIE1heWJl
IGl0cyBiZWhhdmlvciBpc24ndA0KPj4+IHN1cmUsIEFDX0NIRUNLX0RFQ0xTIGlzIHN1cmUgdG8g
ZGVmaW5lIEhBVkVfLi4uLiB0byAxLCBBQ19DSEVDS19IRUFERVJTIGlzDQo+Pj4gc3VyZSB0byBo
YXZlIGEgZGVmaW5pdGlvbiBidXQgbm90IHN1cmUgd2hhdCdzIGRlZmluZWQuIERvIHlvdSBtZWFu
IHRoYXQ/DQo+Pj4NCj4+PiBCVFcsIEkgdGhpbmsgeW91J3JlIG5vdCBuYWNraW5nIHRoaXMgcGF0
Y2gsIHJpZ2h0PyA6KQ0KPj4NCj4+IE5vIEknbSBub3QsIHNvcnJ5IGlmIHRoaXMgd2FzIGNvbmZ1
c2luZywgaXQgd2FzIGEgY29tbWVudCBhYm91dCB0aGUNCj4+IGF1dG9jb25mIG1hY3JvcyBhbmQg
aG93IGFyZSB0aGUgZGVmaW5lcyBzdXBwb3NlZCB0byBiZSBjaGVja2VkLiBXZSBvbmNlDQo+PiBo
YWQgYSBidWcgd2hlcmUNCj4+DQo+PiAjaWZkZWYgTUFDUk8NCj4+DQo+PiB2cw0KPj4NCj4+ICNp
ZiBNQUNSTw0KPj4NCj4+IHdhcyBub3QgZG9pbmcgdGhlIHNhbWUgdGhpbmcgYmVjYXVzZSBvZiB0
aGUgc29tZXRpbWVzL2Fsd2F5cyBkZWZpbmVkDQo+PiBzZW1hbnRpY3MuDQo+IA0KPiBTdXJlLCB0
aGFua3MgZm9yIHRoaXMgY2xhcmlmaWNhdGlvbiwgYW5kIHRoZSBkb3VibGUgY2hlY2tpbmcgZnJv
bSB5b3UgOikNCj4gDQo+Pg0KPiANCkluIHRoZSBkb2N1bWVudCBvZiBHTlUgYXV0b2NvbmYuDQpo
dHRwczovL3d3dy5nbnUub3JnL3NvZnR3YXJlL2F1dG9jb25mL21hbnVhbC9hdXRvY29uZi0yLjY3
L2h0bWxfbm9kZS9HZW5lcmljLURlY2xhcmF0aW9ucy5odG1sDQoNCkl0IHNheXMgdGhlIEFDX0NI
RUNLX0RFQ0xTIGlzIGRpZmZlcmVudCBmcm9tIG90aGVyIEFDX0NIRUNLXypTLg0KV2hlbiBhIHN5
bWJvbCBpcyBub3QgZGVjbGFyZWQsIEhBVkVfREVDTF9zeW1ib2wgaXMgZGVmaW5lZCB0byDigJgw
4oCZIA0KaW5zdGVhZCBvZiBsZWF2aW5nIEhBVkVfREVDTF9zeW1ib2wgdW5kZWNsYXJlZC4NCg0K
SXRzIHNhbXBsZSBpcyBhbHNvIGluIHRoZSBmb2xsb3dpbmcgZm9ybWF0Og0KDQojaWYgIUhBVkVf
REVDTF9TWU1CT0wNCiNkbyBzb21ldGhpbmcgaGVyZQ0KI2VuZGlmDQoNClRoaXMgZGlmZmVyZW5j
ZSBpcyByZWFsbHkgYSBiaXQgZGlmZmljdWx0IHRvIHVuZGVyc3RhbmQu

