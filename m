Return-Path: <linux-btrfs+bounces-1936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4F4842418
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 12:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533731C264BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 11:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBC467A0F;
	Tue, 30 Jan 2024 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Sqvn2pq3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Otxvq++X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84B67A10
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jan 2024 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615394; cv=fail; b=RQ/gVWLl3ZGTpmBbOvauca7UvipwLT2YlUBYGIHHsXf1agRwMNejduVry7x8CrukqCf+aV2C+fKc3fCcJ+FGVebEuegT3fzML/U7B2upxXc4LA7oX8OcxpF0Kj9kCKP6zBpeZfAcmSW7O4/Cb5HF17I24ePJxJ2n4qoKNOG5eks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615394; c=relaxed/simple;
	bh=UOIC2QCqhVMkVmEImttSfhKD1H70F1F1lMjd4hchBv4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nsdV8plfdFmywfrpIt6HlCtP0MTyXJLzKzn79glcHzypSjuRvV+wA0L9IL8H33MJ4f1q+XAF0WnvBm+Thdx+lCkr0bSPgKarFyhq79qqXUJL7mJURweQs1d4uYpqTC51BJCQsfa543GXFx/h2fGRM3SUtkkcL2axpL1cJoPCUuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Sqvn2pq3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Otxvq++X; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706615392; x=1738151392;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=UOIC2QCqhVMkVmEImttSfhKD1H70F1F1lMjd4hchBv4=;
  b=Sqvn2pq3YZxHeVZNj3Z6uCXiJ8mCHm2bnPdnPuyi6+deze0LSAeRtnBV
   PtCrKN05Wqq5lCTXu9yg7E9fET+lmh8MVqpgPIzf8EbWjmpx/zleZLhqq
   qO5EnUCnD4AAw7SDJTjaxiFmJZFEzg45vKCgRIx6sSgPUUWZUPkzUZosF
   3nOaAmhnQ7IMuJTiKmY3WNKCWA22nRhHvv+7iBJqUsOdK6yYHXXM3ANJd
   yb0wyvFsncVK4B3CuSg0d5h5PAR2WBMU5ndwD1wSuKkzry2rU1O76gSJP
   HmL/I09PWkDf687ircMlWj0LU7YxfFj9d95R+1CjQkiaKpMgJosOPxQMH
   w==;
X-CSE-ConnectionGUID: ao+0CVlWSkuBbd7RwZmBqQ==
X-CSE-MsgGUID: UdYbES9jRKyD+w4znBDcvQ==
X-IronPort-AV: E=Sophos;i="6.05,707,1701100800"; 
   d="scan'208";a="8131579"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2024 19:49:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enKLWB7lwfdar3cumOTzWFXk+i4L7nlMf5KoAXMnNrVOwc7c5IVn6LVkO1dllT1dFyGJijPYVShVJRm2bbpMeOJUMUauzFy4Mjkx2aa8rpSAN30ow19ZowzY8l5b5EayPMZTYYfyT1Crw5I/pZVMoXZZcGVqck/eO+deceWOO+GSvjaKdRlbNtE2oDVqH/Wr3wchr6B0n1+eVeLyyK7CPXK4TE+ZwphWBgw1JuvNSSWqzw98X7j7zqSHHG3gjibYJ3fmazKJMMImOwiDhvqrnSuHxoLNOYKvNRuz15phS/DCk8IyOWTDxhJ95mSRkbjvtnLGbKR1uXH04BbsW/gaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOIC2QCqhVMkVmEImttSfhKD1H70F1F1lMjd4hchBv4=;
 b=ZsOS9gVd0rhY3TVVSdTpX8Q5F1iHLK63J90VSXXT08fIMh2uhPV40qpDBo9YkH08godJhzEiuMGvXkSvbGJ2Y1ns5Vb5Y39lomeakAqWRePEeTOTX8fIi9S/KdXAtLzUaGizUUvdVjoShx8u5tKgXfmfCNSKWNbsH8KDqty7BKRaZGNHlNrqm7IpNUiOuCidtJKKOU8oiAeIERXQav3SxNRMVNG3CHSpJPd90wuTefsX1xhVBelTdiNXrH7vDdKaBrPRfRf0hz0vypTvco+A41aD5cLvS3bRZRwn1VFq/0TKHgXQEW9PgvUjttXzBTHP5iUHMq7a1xLnXgSbQ9TXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOIC2QCqhVMkVmEImttSfhKD1H70F1F1lMjd4hchBv4=;
 b=Otxvq++XMcn8V2xNTY3OHuvPwvny1XeaSdoado+ymZIjuX6c6voR1DF9j00+RCjJHwa+MmxSU0V7lcnXGxDr/T9fYgPaOBbTBY3AMhLq/qDO5Ne3oINi/o/Ft2P63GW5Ui8kiBjluV0jpnVq9AlHUH01MDwetE5fJ8tN8IjmU6A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW6PR04MB9025.namprd04.prod.outlook.com (2603:10b6:303:24a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 30 Jan
 2024 11:49:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%6]) with mapi id 15.20.7228.036; Tue, 30 Jan 2024
 11:49:48 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/5] btrfs: add helper to get fs_info from struct inode
 pointer
Thread-Topic: [PATCH 4/5] btrfs: add helper to get fs_info from struct inode
 pointer
Thread-Index: AQHaUuHBoOtNw1OHsEKi7K5Zbd5FrrDyPxYA
Date: Tue, 30 Jan 2024 11:49:48 +0000
Message-ID: <da763ce1-dd25-4fe7-9bb7-138dc6350e04@wdc.com>
References: <cover.1706553080.git.dsterba@suse.com>
 <edd12dabd0ce57ba84a4c2b82c51becd64fd7a6f.1706553080.git.dsterba@suse.com>
In-Reply-To:
 <edd12dabd0ce57ba84a4c2b82c51becd64fd7a6f.1706553080.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW6PR04MB9025:EE_
x-ms-office365-filtering-correlation-id: 70f314bd-13b9-42ba-1321-08dc21898feb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hVg94c2WQJ92YL2LhKOx7NBPg4z6ewHnKpniUsMbVRBKyjOMiHauvmGSlGQxgP0QAkDVIwxWB1vCIB0Wx5+mYaSKRFk4Bjz9eLMPYx1frsnh49nBy8h8GIv6WXE8RkxqpXCAqG5z/J/Au/wz0Xf7r4oSBtMVM9MVC4djo9tZtEeW1zdQsbHS9t0weqx7ad8K6UNqiKvRS4GycpclDwkUu67Yd++JvOpK9q3j/XUk5cGUEEZUsBPDH6+liXezKn+KNqUisMkeTEUP1qy15FN9L7fDt5TdaO2hbi2TnOa/ZdtCvuZNY792QhfGnVTyVqo/3hZTz4EGQZGJnOf22+Z26YGz7pHjWIarRjrx8LXy4bUQ7aPBD2sYBbmKbHnpu2HZ3dS4rVrA/TBzPTfkPsJY5NlbKPcp0x4OJ0IEzl+O+HXA6aBV2/ZP3zcWWbkg1nd8lkX3FQerDDb0/susKVhu3+/GU/vU98m0oF/75L7YE+H/iHGdVT+OBNXPJx6hqARffjz6L3h1GKaesRZA4fBN5N/+rrKPZu78IPj+w5U7SsU0d4iQ2kF/ElKUKyBp67Cm/Ox+GYkphSMy9vNVyCntF89wT5c4vg/Ws19MoYxNWYVQo7Ta4/UbuilZ+3CZGhK1DaLUCj4OspZQB5Ien8BBN8eUPFCnnTVTCRpB2VH17+QemdEyiBPPRE6KxFgzbcpW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66446008)(316002)(64756008)(66556008)(66476007)(8936002)(66946007)(76116006)(8676002)(110136005)(91956017)(4744005)(31686004)(478600001)(86362001)(71200400001)(31696002)(5660300002)(38100700002)(82960400001)(2906002)(6486002)(2616005)(6512007)(53546011)(122000001)(6506007)(36756003)(38070700009)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3pOeHJGZ0x0Ynh6Zmd6aENzdUxoZEEvb1lmK2lpMTgzWHh4bHB4VXBGQmcz?=
 =?utf-8?B?YXc1aXVmWU5RUVRjclVkaGlFSVQ3QzNUbURHcE5EY3BxaCtlMkxuMTMyRUFj?=
 =?utf-8?B?dVVma0FMaHl6Z0JPRGRvZGorYmdMa0xURHRwc0JYZDVSdkxGSHJaTzR4L0lG?=
 =?utf-8?B?UWdtaE9qeDJNdlBVYkdjUlJMeUdEK3Nic2g2T09ZVkpQaXBsdXNqaGlxQUpB?=
 =?utf-8?B?Z0NOcStjbXhhYTBtd2NuNnZTK1FOZEtQRmJna1RYUC9EQ1NhZHRLSWJlT1ZB?=
 =?utf-8?B?ZklnelVldi9pMWRhb0JxMitUejcrazZqVC9XZStjZ3dWMEJLRTRHdThkNm90?=
 =?utf-8?B?b0VNVUpmb3UwVUZBQVpQL21weG1zMWJPSnA3TTlyQmpkazBYbFdhU01vTDl0?=
 =?utf-8?B?SDBYdDJGY0F3aXdQcjZNeU03ZnF2M0ZyVXk5US9jbXlRT3hLdUFlYmNFNnNh?=
 =?utf-8?B?MnBlTk1SUEFsbXFPbUhZUHdkZmxkRCtZWTFqLy9wbVpLY04xODdZTEZLMllB?=
 =?utf-8?B?TDlNV1AwczJ6aHBsSWttcWVmdGNud1RjN1g1SkdEOGlYODI2YTlXNi9ialls?=
 =?utf-8?B?SWluSlJ3VGVIanRVZDI0Z28zREtxaE51UDVDc0h6SW9zWHl4QVd6djVLR0Vs?=
 =?utf-8?B?M0lqRkpGMk8xQ0YzOXkvbTV0L2FPWklpZXRTZ3VlZXVycG9CUkVGLzV6NDR2?=
 =?utf-8?B?bmZteWtZeUQvMnk2Y3dtNkozdmZmU3dvYTdFWWhkR2NSd29TRWF6R1Q1eU9T?=
 =?utf-8?B?VGgyV1dkaXpySnRxNldLSGVhTCtCQkFuU3k3UUZsN1JBUHJoV0l2bmoxY21B?=
 =?utf-8?B?bkZEZlYxUlZVN0VmbjRSUTc5ZXVvN3ZvVkJ5bDFFU3h4MGNkOHI0TTRtdzJY?=
 =?utf-8?B?OVJsYmlobVAzOFhUbEJ1dXViNTYwRC9uU29rTHVPVkg2bjlWYTZYUTNyQVlo?=
 =?utf-8?B?S0ZsTTBKSTJuNmVMdE1mU0JtalUwQkU5TGJPWUlFTzdmVnNXcnlaM2tldkd5?=
 =?utf-8?B?bkZqS1VQSkpxZ2dLVlJWT291M20yMWpiS2ttQjBRalVwU1h4TDZ6RWpMSHNR?=
 =?utf-8?B?ZmZkYStxTDdaNkduOGVGdlAwMnViRWRMa2ZCRmJselh1d21XQkltWHo5bFZO?=
 =?utf-8?B?YU5BaHhIUzVzV0R2Y3B3cVluQUd5MklEZnhDek40bW0yOXBXKzkxOHZTS3NN?=
 =?utf-8?B?cTUzZ3NwR3dONklKQUY3WXhiN0ZRVDRnSnE0VmM4WGtVcDJzeVRvY2NiTktw?=
 =?utf-8?B?U203Zi9yVmN6RG15a1BuWnZtL0Y3RE1TT016SG1kZTdwbUdHN0dZc0toNXF1?=
 =?utf-8?B?WXZjai8wWnJNOERnc0czRTNXMU1SV2dXaTMrbGR1dlpibWZLb1BPS1RhYW1m?=
 =?utf-8?B?dG9JNmpRMmJiWGE5WVRiZndRUDJOeEdrOXZPT3ErUkZzSzEwZC9tTTYxYXAr?=
 =?utf-8?B?ZFllVldBSzVJUDUzZmRMOWdHZkFQelFBbGRQOHgrWWlzNkxZWG1mU1hCS2hC?=
 =?utf-8?B?ZktvMjBKWnlGaXZqMWJDUVlTaDlUaEFUb0QrTHQ3ZllVc0pDWjk4YUZKSDFQ?=
 =?utf-8?B?Tm9ka1VCc0c0cmxMRC9TMzFxSlhFUnJvd2pXQmhPR0NaNHZ1SVJqMVNEY3hn?=
 =?utf-8?B?cldUeEhFYUgwclVleFpUeVBCY0l4ajN4a2E5NVlhNi9YSHZSWm1hZlhrc2ds?=
 =?utf-8?B?eWNRbGJOMDVVNVpqTXM5ek9IMXJVVDVWL1VKL1Vza0d6R1ZmaCtIQkFxMDlQ?=
 =?utf-8?B?MksxbDRxL3MrbXl3WVlmRDRuZ0llVm5GeDJxdXNCaVEydHptemNFMnNuTWFm?=
 =?utf-8?B?RWJGay9QUDFjVXNuYThFdk9QeUlOQ3FSYVdIZklqblRQd3BPWG94S2J3N1g2?=
 =?utf-8?B?V0ZJdDRORUdRaWJRNzNNTEVGZ0hBbU8wVCtDYmxkTmpiTUFaYWFzaXRQZ0tT?=
 =?utf-8?B?aTJyNEtBK1MzR2F3dUlYdXlic2dDZG1oVjF1NVhSV29YdmNGZGxkWmw0S3BW?=
 =?utf-8?B?b1NQd2NHTnJESzZVK05FN2dNb3FOYlBNL2M2NG9kNC9Qdy82YllqcEFYbVNa?=
 =?utf-8?B?ak9iZEZDTXp0MnlTcy8vaVh2cTFMZGtIZEFrbWkrYUN3cXZVUDR4TEdaWFBo?=
 =?utf-8?B?Y0hjbnNFUEI3OGNndjdIRHRQWkxSWmErTXpQQkpQc01GR0k1b2JjVUwyaWtE?=
 =?utf-8?B?bUVFWWp3V3dOSEhEZCthSFQrN0NMODQ3K0FWNzV4VDZKWXgzcnBtNERadDBl?=
 =?utf-8?B?UVJnT29nTFYySU9JZEZtc0x5c3hBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8455CC1C0B119489D35098DB58CFA7F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AYoB7fyDoXED1SAbqFUTC0mIDZwuj/J4DZOOkfK1TRxgkR+DLmv/Tnk4/gOUgUk4I0OYHLqX77OcrWLMdFxTT+sefryUGMh5+NFdTpWE+F39AaXj0bszUEYFjoP2+17UwwLkg818F/hCiuNhcct3h2/ecfOwWBkPbFP6Df+xlmMe6WCkCgYUR8AZZP/EYbbrQ3dYHz+7KsfAUw3Y2BNC7uGOuwVRzg/xMbfWwpRNsqvGp73eJsL0bl2kaqvRax2czMn0xusYNwpy2nuZkWjR3m9+YGo6HlCYyJgaMpAjakmfKjdM/LFI7HD8cNtlmAW3ufJPztlbTjcNbvVQQ6g02yvXcd28RFrmwh7pwPe1/nX9iIYV0eeNSbPhCrPQMl2h/YkuYQwUyHNePLY4U39svnLrzIzaAXA8qIbQG/q5s37pDZBB8XWn4EA59RX07fSF5NW3qO956sg0/ks2wYJlVGGN9BetC7iZQ3h0NGEhwlhbX2EjlTg0oaYsjWqVCeQPtxabh8oVJ46oQLoTu80jMdanZsqD6jpO8BDPkLl+CJccgqONvSljrfNB3xdprWSgff1LexeInIpTQUmMA2xFtJT2NCyTxFtkTCgIHt0IgJ729Bm+b7sOcS02agLBKNCt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f314bd-13b9-42ba-1321-08dc21898feb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 11:49:48.7933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQpnS9CobOF3036c2CKcUWPKD1Jd1TF3JzJ9AU3H1/Xweel8XAtejC8wdkUWk1pYbREIOwGcJT7jjAp+OyXa1v4/dtOdGLoIVYVtBm2SsrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB9025

T24gMjkuMDEuMjQgMTk6MzQsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gZGlmZiAtLWdpdCBhL2Zz
L2J0cmZzL21pc2MuaCBiL2ZzL2J0cmZzL21pc2MuaA0KPiBpbmRleCA5Y2I2NzFlZjEzNmMuLjdm
Y2JmOWUxMTVjYSAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvbWlzYy5oDQo+ICsrKyBiL2ZzL2J0
cmZzL21pc2MuaA0KPiBAQCAtMTIsNiArMTIsNyBAQA0KPiAgICNkZWZpbmUgZm9saW9fdG9faW5v
ZGUoZm9saW8pCUJUUkZTX0koKGZvbGlvKS0+bWFwcGluZy0+aG9zdCkNCj4gICAjZGVmaW5lIHBh
Z2VfdG9fZnNfaW5mbyhwYWdlKQlCVFJGU19JKChwYWdlKS0+bWFwcGluZy0+aG9zdCktPnJvb3Qt
PmZzX2luZm8NCj4gICAjZGVmaW5lIGZvbGlvX3RvX2ZzX2luZm8ocGFnZSkJQlRSRlNfSSgoZm9s
aW8pLT5tYXBwaW5nLT5ob3N0KS0+cm9vdC0+ZnNfaW5mbw0KPiArI2RlZmluZSBpbm9kZV90b19m
c19pbmZvKGlub2RlKQlCVFJGU19JKGlub2RlKS0+cm9vdC0+ZnNfaW5mbw0KPiAgIA0KDQpJZiB5
b3UnZCBzd2l0Y2ggcGF0Y2hlcyAzIGFuZCA0IHlvdSBjb3VsZCBkbw0KI2RlZmluZSBwYWdlX3Rv
X2ZzX2luZm8ocGFnZSkJaW5vZGVfdG9fZnNfaW5mbyhwYWdlX3RvX2lub2RlKHBhZ2UpKQ0KI2Rl
ZmluZSBmb2xpb190b19mc19pbmZvKGZvbGlvKQlpbm9kZV90b19mc19pbmZvKGZvbGlvX3RvX2lu
b2RlKGZvbGlvKSkNCg==

