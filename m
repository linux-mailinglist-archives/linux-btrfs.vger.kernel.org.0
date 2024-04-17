Return-Path: <linux-btrfs+bounces-4326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D380B8A7F3C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B342838B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 09:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4280812E1E4;
	Wed, 17 Apr 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D4xzxL+y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hP8Dd4Mh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4068812CD98
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344783; cv=fail; b=Tn78Yvj0lKhXrmAwwg7mI2c1dvgRBRwihxyogeZTUfoziS85/ImOAFCLLUJw7qNW2a5dWh0GMR9xdvAbCtQmGxZWlMwgWsI3KQjDi3FsS+xujlhIMqeo1r9jmC3rdvka4IYeArWIjcga/qwTh1tzlRt877Sc6FurUcwBwWqFhN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344783; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a/ixNxKrenpw4JTOXDyRtugn3AWEXuml7mKupNY4RvXJkYn0sxh9b3aaTT7Bsc+QNxPs46C1ZjrrMhfpXVqHh+/uy06XUzTn6dr9lOLfxmfiBfee5CL6fWSOj7LGn7hcLsB3nlxtfY701jK6/FrOOuySMbSMXd42fwrcn8t9NE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=D4xzxL+y; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hP8Dd4Mh; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713344781; x=1744880781;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=D4xzxL+yT/6OVlvKxMUAfHDBa4EjYMxh7cM2Z4LcRhJUVdAX+F1tf0dU
   rG9BNCSybjKNRddGjk3IWfhUKsko6WCobK9/GkCVbIBKDUIswgP6wXMTw
   tR6m1dt/+xnCJ1j3EJskMep7fWQqIs9CeXS57pDAnzK1BfQCp7n0Z/zUl
   zats1RK/tuBTxBJXgLHKEIAh4t4Q2rAhKezPHhbEv3TKa00JO+3kPkVRd
   EG+sBrxw5Fi+VMzJDwT8ZTv+50w/cXZSWV3l+fXYlbDwbNC6S2MDlV2NU
   ajoPh4qTTCyTNhx0cdYBgigNLsedbNHRD42OinUcTVUWC9U8ZJkQipQIn
   A==;
X-CSE-ConnectionGUID: ahYorYD0TdmxaM694M+63A==
X-CSE-MsgGUID: IaTw2FwISsG9NlslxCSxmQ==
X-IronPort-AV: E=Sophos;i="6.07,208,1708358400"; 
   d="scan'208";a="13998099"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 17:06:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2c7SJMHRlXOO13uMj7fuPX2CSNGDaPIn0dZEWzqTvaMG98QeUtx1bvykhK/0TGTHNr9AuIPrO+4Ktl7jXLke3OMkn0zhRRsG41CJCPIdBQ8GCbSmf7BE9Dwu0Cl09+tNv7OWdQ0NixSYJ7AsrEehuaDFfk29w+2U33JennjhsbeQfLq5IwLzwAvAgc2RiR+TzJU9xucpe7QVtewz4He4YfdHOPkhg/5B8Zuv01dK101rEaJbSA1V8WAAlaxEna4kUA3ph0PXrSq3zGrVDyEi3WSVKju96yhNkgos43q/Vi7d/VBbryQFZ31iDWjBmkqMsN/aWWRe4UxzEJRXhDcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=BHGVMOu/MP8EqZNOaSwqHgRQjmpivYrhvrh4Eynn9UKcErZovrm7ABT+ZP0AbzvgVFk3miczLq2hNvu5RjFnCiaf3cN0yGdGXEMO9N7jNAJXitsoVQ6z7AjsCuvRN8xDLYI5N6s8lrTsMxeaxufYkedYNxyaTd93y88L9BZWrrnlHe2iDw4rI9DY8ZfuP2bygUvtWchQSYIlK23sMt2bqgPXXFzXK3M/L5vppt8FnLRpjIiv1gmx/eOCWg+euUZ527l8bsi0y7teoAEoCOpyo9sJhwULIqPvHG03fsfh1ybhHckjArlCmzy8Upi+Oak9Ucu+YvkRwsITyD708M2pCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=hP8Dd4MhCUYkeVjx/nd4QJAarTJdVeKHyHiQXjk+N2ZiMzbcUkn75yDSIlVUobiGxUnuSxO1Eaec4ac0wbHcc/IBF2oxg0KNpTRfZD5MYMo9FxkW44sH2BwgB/jxo7e20DtU9Wk9ryVvdA2M4+ilQGdw1c9zNIta+BL8wgVF/bU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7257.namprd04.prod.outlook.com (2603:10b6:806:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 09:06:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 09:06:18 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] btrfs: fix btrfs_file_extent_item::ram_bytes of
 btrfs_split_ordered_extent()
Thread-Topic: [PATCH v2 0/2] btrfs: fix btrfs_file_extent_item::ram_bytes of
 btrfs_split_ordered_extent()
Thread-Index: AQHakIN3OZgZAU7Q4U+fJdDznF+UhrFsK/uA
Date: Wed, 17 Apr 2024 09:06:18 +0000
Message-ID: <84720e3b-3e87-480f-bae5-0b1161097245@wdc.com>
References: <cover.1713329516.git.wqu@suse.com>
In-Reply-To: <cover.1713329516.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7257:EE_
x-ms-office365-filtering-correlation-id: dd67f619-d33b-4e23-20a1-08dc5ebda497
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +oCym5dOQbV0mrQXHpQQOzyO9fDLioaAvos3kxt7wQ1ycn1AGHWtorbE2YMNbSQDBlY8ijN4ct6KNLMc+shRf2yTue2lnuq8SxFcESma4PpeLlXYVYp47zqrBlLyrzLHr2x5KJG2AkizFgflWyWr2IrtS9ZRRJwfrgrVFOydqSOku36g89YJu5SPU9k6fmycWh/Mxtx9mSVzCbXFfS+zg0C0biGyLU0FVgB2E6Idxo+swWAC0JJXXHr8quScpEsC7lNSltH0SazAT0GPSfgC6r4qf6lmcGvpU33abHYN2x3qbsJHgKN6Gyf7gIoRuy3VP9RzwydRAFZcCqVUGe8Si7VR6XEvWaalh9no1qN4GuAzgKt0fcBpPXbV3WSBrqy2iUumFiY+58Fw8kwrQNEIkSnHGfL9vCTeelnqo920z/PBNbMkDyi1bZnlqOcArrfgjQfFvkv4KEkYG+tkzRqDhcNDi90XDWgQzUlTDaCiWkoEri1gMvIedVab9yKLkVr76HYNVIgqZuUY9YGgBaknv4rEOeQ0vhiz4jRUA06CmKkdKmGCu3ncIb3PJFPPqeqJqEWJIUlyXShCqaChq+T9BboHIHs0wy/2uk3pH+QU25AkXbG4x9J6rzKmwqVLEnpeCzHrB+LI/o3Bgt6TUxyjXBTALPuaKdsgD17bG5bp8FoACnSAMg806jzRSKS4qvxpO75auLwQfcilkxqpg5Kp6s1i8xe1lXs71gQBFijokwU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azJJT2ZsOUR1WkF2Q0lCU0hXUTNjZDhFVFc0Tk02YnpjbmwxZGM0TmhqRWZW?=
 =?utf-8?B?KzFENlZKSjlnbGk4aThSZHZCN2Z5UVcrRkRKcmRFMHh6bjNKNjZVYmxsWmhX?=
 =?utf-8?B?bmhkMER2eUppZjVyK0tDcmlCTnFvVE5LcU9uSWkycStyaGF3eUpwRHByMEhu?=
 =?utf-8?B?NDlVNVEvVHlidXhKSzdVUXAwYzV1cVZ6R1FJcXNRZVd4RU1MS3JyUW9odWU2?=
 =?utf-8?B?Uk1DL1ZYVzZlN0pGUi9zbFplNVc1U0VRNzBwUjVZYUZxMmJOZUFnSnlxREVS?=
 =?utf-8?B?UVlpaGVSSkhFb2VHSmNoZVQzaklUYXBBQkZQZ3B2SjdpM2wwS3N6aW04V3Vw?=
 =?utf-8?B?c0x0SUQrUGIxbGRzclcrTlRMMmJUOVlCQlJNamhLQzcrTHBYQTNaMi80dVE2?=
 =?utf-8?B?M2xPa1NQb0RUa05zb2FiYkVCUklKaFo0dUtOOFpJUFVqbURSYmMwVFh3NVhW?=
 =?utf-8?B?Vi9vZ2FPWUYyMWt6bUFmUGNvaXBreDRvTThBOHdPb3FGTEJ0Z1hlZGtwR1JD?=
 =?utf-8?B?VXVoNlNRNHpMSTF6bmVvaERpV3BBNXdqejBrOHFPTWkwRmppMWFIcktIRlk1?=
 =?utf-8?B?REFyRGdodEJRLzJXM3BtQVhWcWtVaTcwZDgrYTFGQVFScUZUMmc3d2pCRWs2?=
 =?utf-8?B?QUNuZStaRUYwRzdWQWM5dHNkSWVyQnpCWWpnb1dmdlFzblJMeWxRTlVBQXhE?=
 =?utf-8?B?b1luNHh1NzJ4YUlsNExNb1JBT1FSMVN6ZTEvMER4c2NmWlowcHpkY2VNNFRO?=
 =?utf-8?B?dTRWYmxrMlBXVXQ5Q28yQ0x3dEVTZ2lIRVBpNTlmSlJ1SFpuWWs5dFRDSHBK?=
 =?utf-8?B?TmxQemZJY1ZidDJJL0ltSzhwR1hFOXE0bE1pZHdBU0xlKzFkM05HeC9zMzNU?=
 =?utf-8?B?eVhYanF2M3RSMzhYM25TSWxrVUFjMSs5RlZBOG9tc0tpMjVodDRWdkdodDJq?=
 =?utf-8?B?YlNJd1o2RmR1a2Y4bXY2eHplT3VRZ0FwVHBBbWhMbmcvSVBOZUlWSTVGZGUx?=
 =?utf-8?B?U1pHSTUvczVWOUZteWZ5Mjh1RlhHa1VOOWpBRVQ5QWxkOVJuVnBJeFZMNjRt?=
 =?utf-8?B?VmExdlg5bVVHekFBQWNoeUNhak9UbUpnTkh4aDFYM0lYWGdndUtSZDZtR0VG?=
 =?utf-8?B?eUhuaUc2dy9kL3lDM3FIZUFiV2IxSmJsN2dGOFAxNVpzazdsZlZMekNmVk9v?=
 =?utf-8?B?VndXM0NMNDJuWmI2aTZhZ3JrS2RhdHU2aEpRbXRJS3k1eE9YRjY4akd2MURy?=
 =?utf-8?B?WDlESXh6cWpoT3FZbDNqQ3plVElnQ1VJVXRIUlNuNHhpL1NETkNhRmJrMnBy?=
 =?utf-8?B?VjZreVB6NFU1NldLM3Z6QzdlUHNNMlFGVWh4TTdNdmFDNTRhMHU1QmlCUUJw?=
 =?utf-8?B?MStDTlZOUDhzOEdJWC82WmlQa3NKVDk0M3A2UzhETXJjZWRlMi8wczNMWU41?=
 =?utf-8?B?dllOQUhQK242NmxqSWhWZXRGZ0dKK3ZTUjZKOEk0Q2lVaWljNGhiSTF4VEFm?=
 =?utf-8?B?RUFzWnJrWTNiY3gyY2xZa2RqT2U5YXNIdVo5OWxuU0FTVWU1d2RVWUszT3B0?=
 =?utf-8?B?am16ZTFzSlI3ZCtsOGhxeXFibzVwUEZqRWdpR1Bab0tmeEc1MEtOTXlKVTdZ?=
 =?utf-8?B?NXlyZGRyWFY1ZTF3b1BiYTduRjFvUHhwa1ltZTlmL3dSTFcwV25kanIybTJX?=
 =?utf-8?B?LzcyaE9uYVpMUHRMeU96VXpiVk5QeDRLSlBZTFRxK1FYRzJqWHB3UGYzOWRs?=
 =?utf-8?B?SVhFdEd5V2ZzTW1rV2FQY0MzT3NjV0xLWDVEMytnbENLT0FSdjRUMVZTUE1X?=
 =?utf-8?B?Sk1ybGlXUHFHQzJsNjh3Q3JvVDFCQUE4WW9NZGhieEJrTmUwRWtXS1l2VTZJ?=
 =?utf-8?B?UWw2WFNTOG5RbXFPSGFxRTF6akc1MmV1SlJ2NXRnY1BGSHBGajM1QVVCT2dU?=
 =?utf-8?B?ZVdTclpWUHRRVE92enM0YmRUOXFHY3V2a05Nb1p6SnBLQkJ6OFlmZS9maERt?=
 =?utf-8?B?UVNackZEUFBJaVhqL1BjWkV4NkluYWVBSDhXK3dzYU5rNXoySnVlUExWSy91?=
 =?utf-8?B?Uzh5aFRzdjlQYlduKzFQN1Z0ZVZTQnlKYVhWVGM1ZzJFMGxUZWM4MG9YOU9s?=
 =?utf-8?B?NGdGQStGTTAyMkg5Uk9KVGoxTzM4WmwxbFdZTXNLOWpzdHV2d3F1MnNrK3E1?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B333DBA1E762E74AB8CC3A1F8747EE45@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gI4Eb3ssqLHcj235Z+hbLs+sz7LHDRUu1TV5tqUT2mgGm/qr3pUbRK2bTDhuEw3RWthqvQf/rtJ1BunmD2urTolymVKlDY8c5qZCj3Etbrqam8fu/lOn0+dS2SyP2weS0nTzZB/ieumoVILrSp/QeggIAl7zakmpZBICXLF1p0h6di9O7Xfid9AtLB2IZIc0SguF4JIgPE1pqfA3Ro+171wy3Q+MGmN0ZpNyWaC2wGZ5MM22ZfV66MVZ+xaRRWd+3IcQ+ybRUAHwcyYTXWgVxiYNhhstGvU5UrNUUAZdPZVMfTY3RcC7nAsRW8cdCRzWIzFzJj/mqSNV+HYIix/X4jHUFxtON27uZ4BDl7FmZSWoOaWD0FiKBbzYK8Un+sat+IcOlfv7kVnlWfExRuBgqI/HamC45li7HNdGgdxr+p176UAjeq3w/bJt+2L/jXAqUvlcI1P2TjWN2+W5S6PCNFO2RHUpJDLd1TO3wA+k43+vCG/cTH7mIkgOd59PU8/xdvZK4oiw+otU8TNxsEN5Q5s3c5h6c7edt9EsfU4cnerr++lrPyjDmzCnsERtRJnVPf9Gubw3WwgGVspv6OG9DTFwgq9puNiXPwT3D+lUu+OOS8N6N4QoFWvI0xW/CiZJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd67f619-d33b-4e23-20a1-08dc5ebda497
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 09:06:18.2547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jF3tmEDPTu9nuCxuat7LezORyBdybH+cao75eehmTyI+Hbdb/LPN646VwmLx9Bs0C8xeD8zxAlnc2k1S5gfujO4rhdeOpnI505ndHbRPXz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7257

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

