Return-Path: <linux-btrfs+bounces-1931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460EC841A85
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 04:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A64287047
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 03:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C601374EF;
	Tue, 30 Jan 2024 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oGPCWMGQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zE/gl4jc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2E437169;
	Tue, 30 Jan 2024 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585240; cv=fail; b=QvIBtGOIMe9Srw3K4LyT6rpQdSYGIcj3Lc37P2O3vR2TdJFko3Vcjbwj79T4VT+cvzNxozJK6FX9kBNdMwzpg42HwE+PvEPlZ5A3ub0wpTRXJMR/1/EFjU/dw8l1TAR9FKbj3me/ui5UGqNyv7xRmOou6CdWAIVT361g3ATu8Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585240; c=relaxed/simple;
	bh=v6A+zq2xQeqWkZhJ5sO0RpwGIFi9dvpnU0WBtysbsUk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AEpIvtsYPcjN6NlTUvFe9WScgunTCw4sfq+a2Ucl394HsUWOHRSEihHEGjJyi2roxvuVBPAmjSadbRHPkcGT0heIoZ4tctWt8VXZXtj69FHXAFl3jgAZE+Nu8Ntgl6ZUDilV8YwIds4UQCOG4/VcVP3maE8d7MsrrfwRXhKn4FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oGPCWMGQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zE/gl4jc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJi1Ng029605;
	Tue, 30 Jan 2024 03:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ni1f7E6Yj2tUlmLX/3yc0Y8GR2vTawQUj+kq8R/KSY0=;
 b=oGPCWMGQDYMdtVII5LbvrhRMgZHQ37DpXakwIz5YvSvGxjc/uBfbMyM5FFvcJ51Hmwla
 A7tMwx7F/whT9LkDNAbRkBgcsDhtqDvXyKvMidqFDmq1BVQoIutxQm5heOJIa6A1t7yo
 e+Ey6lGCRZQByk1TtuL7ZKCVvWQOXrGKbBXoHyoP90GS285Y/98rLgHIaJIuYwUBNCis
 W7DeOsWXVphCB13bCwgmHO9NhMZYMEZ6Z5rY67PzI+KY1FqVzZuzkbHWRsObTa6Su9Ym
 tbclFJQeXXoqrJt6yWwKytIY/Wtp07XTDMDFTIphQdZwPHAMAbo6ddj+jM9IQmWosZmT Ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8edfqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 03:27:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40U27jd3031397;
	Tue, 30 Jan 2024 03:27:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96sauv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 03:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUJh2IeP3A0IVf9sb0a0+z/iIrEV0oAg1AJoCZ0tM9f5ykfc9K12v+G0jrgehwtXOMlPd+VMG985xKq4JtGdqnHlVDWwvFyY+tr8u9nNMEOzvmCZIphTN1SxJ0uO2FNFiUmxXSVBGFy6L5C5LfOhfQDVMTdb00hi4OzuVseaP7Ie2FrbCqnozJFy9yZGiCj43GXczyQbE0i4EGGo9y1pWbTNxF38kqtGkeOAjE7CKesuW3nzvP9NO5EjCJtAqrNAYT6EstwRo3zRQddVkdFrQNws4swpnJZib3LrXwiH5rKtU/wzT3paoGer16yy/hpmoN7UoUzGQgssGMioYcoHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ni1f7E6Yj2tUlmLX/3yc0Y8GR2vTawQUj+kq8R/KSY0=;
 b=gHCgOcdtz0tIFefwdpgCAd7I6jvm7fO6O+XY2Ufyl1ckezXzJ8mTSRNUikxz2MJn5SVqcln7Uvt3FflvSe1yO5EzTJeNGqFHOkQKOr5Qph5r2Lh4zY88HR/qCny02Savo17QwVhdQQQ61jv/wt49vMMzOpWFq6psxl6SfMDRlwRPjn1FogcKHkKGfH61zw8+u9KhdQ9CYgZnYj/tanaSmD5Nk1b0ywirGsVsY3NZtIUIRoL5el1EpKzXKGUO3GqTexLSWxGTPQLXbo25ls8sjfC8ThDXLJKXhqXP0LHx0BY+YiMvy4u7+gQcFEhg/atqMojpL7CtSnsSz05CjS+Zfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni1f7E6Yj2tUlmLX/3yc0Y8GR2vTawQUj+kq8R/KSY0=;
 b=zE/gl4jcBXkr3tgMFMSeBqj8wqrw7W4HPJGezeehlPhcsaGLhbMX2TeJsxDL+VNKl/ubf5F/QMYh6I8Hh1k879z8xkavIVbcj16MfwHTAFdmaU9IIFVGrJ0bzZ+EaJA8pI370wVCAiIRkEM4g+8df4vIIvf9cjGAQ5W4LFNvG+U=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by MW4PR10MB5862.namprd10.prod.outlook.com (2603:10b6:303:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Tue, 30 Jan
 2024 03:27:12 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 03:27:12 +0000
Message-ID: <7e036e38-7fbb-4237-99d2-b8d664ccddea@oracle.com>
Date: Tue, 30 Jan 2024 11:27:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: verify the read behavior of compressed
 inline extent
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20240127204417.11880-1-wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240127204417.11880-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|MW4PR10MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2b64ec-6aef-4ce0-4d33-08dc214358e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tjp3GZikKyGi1d4ZF7vZ86RzIkNi5kY60RuHHq/j6slrNZS0k60seIBkbJuCOS3BhQWeffzkC2wsONrqFaE7wKfU58MXB3d6pZbZgzTAPxN4ya6MNubNeUP6+zdwoHKrfrrJRksf/b80Her1wDRpGABTmsjtZkY7yyxwtWq6ghGC3dyHZOx2f9zIdHAeJU7QjEb5c4oQohvvykcvzMREloQ1CcdTTUSWI26B/wpns+4fkXpAd5osu+oJ/0MVZoVmnXqYxWkDIYc7E79YsvPukUkFQd1+dBAgHl/ZKatFdxM8dU4DnI9YyT5cMRtgjs3T6+/vwi6wfxSRjbP+Iiezl7E8U21M6Q2dWt2B4WL13jbjq9NQ1I4Ro4RhkIQcH2wufijjksnizxGrVSS9mdMS+GQimHJZNv5Mu8JBPbu8pkaXz2ed0ke5ElGJu3/5ObfDkVDWYxM2efjmxr076g3bSa4VzgWG/0v+hH8VnXWherfj2XXLjh1P4QGA/aFJaNT+e8s/5h2qeEGbO2vLPgY92MeQWDZCXf7dEnNj72wzFg69as7TwRQUmu59QOXPkPYv6lfw7VtnceJgyL+gD8UyfUfN8nUI1tjm8NCB5wYPfFyTh4N6RTvBUvMBMoOk6CNTZPBnf7lrskVsJfNrcHvlVQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(6506007)(2616005)(53546011)(83380400001)(6512007)(8676002)(6666004)(8936002)(5660300002)(26005)(6486002)(66556008)(66476007)(478600001)(316002)(66946007)(86362001)(31696002)(44832011)(38100700002)(31686004)(15650500001)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dzRsMUR1ZWhJQi9tOWxlbGV6TjBlS2VqeHBsWkkxRjNnMGJtS0MzNUgyQTJU?=
 =?utf-8?B?VXFucnhsRDVNUUg5Um0yOHhNYi83c2FyVitWWFllSGRaL2NDZ3d5QlF4MUww?=
 =?utf-8?B?eEdLZ2N2UXdaaVRNK2p5T3kvMXRwOFFtK1RuWWYyZkFMUzJITGdPOHhkLyt5?=
 =?utf-8?B?SVhEN1FaaXNMcVZjaC9LYVZoaHUxbVJDNUh5b3VHSlFJOE9KQlFoNVRReDdG?=
 =?utf-8?B?MlRZeGRiWTJuaEdNQkJPTndFbTNIVzdXTkNXcktQM0lRNm5DUHhRMklpQndv?=
 =?utf-8?B?eVlrNU0vc0tOenZWZDNEWXM4OUhhdkFveEV4T3pud2tJTk5PdTFwQ0hOQmpm?=
 =?utf-8?B?NG5scllBSFVhOS9KZi95a3UyUk5EMHh1Q25ZV1pQa2MzTURiL1U1Y0hpQy9j?=
 =?utf-8?B?eFZCdTZmSGhkMktKb2pkYldILzU5Z3lZMGtRMDc3WENNT1Z5dDJTV3BUNjRS?=
 =?utf-8?B?Tk95cnU0Q3NiV0ViTDJ6ZTdzZzRsUjBjd01kSFFneFd5NklxeEhqenRPbnRU?=
 =?utf-8?B?cjU0UmdjOW9sMDVmbGpvTGdCUlNjaWIyMVRzQkxrRC9jc2RtTzJvRFFrT1ZV?=
 =?utf-8?B?dHNFeWlEMnd2NVdJSVZKUzhpWlBERmw3a1NOd1ptVmxNdjU4WGhJbkxvR1lJ?=
 =?utf-8?B?QTVYVmhNVGFDdlB4c3Y2OTJyazlpQ2tlbCt2OENrR1VBZUkwRWNqeWNEeDdm?=
 =?utf-8?B?ZHVwSllnbnFla2NpUGpQZWlMeVNRcWFOaFVZL0VYZVZlTytWcEFBbDJJejc4?=
 =?utf-8?B?cUhMQlNBbVNyeENDbXZPVWRQem42SlRta2JQeUI1SE94OCtqeURoMHlOS2pY?=
 =?utf-8?B?L2NKODBzWUdHc0xuUFFpaVBjU2pGTWQzNnl2dUM4YVpoWFRlV3BVTjlaMFdh?=
 =?utf-8?B?bys4dFFHMExIOGpVbDRqU0N4TnlYUkR3NHFqR3M0VmpTZ0ZneUZHb2h2SnpN?=
 =?utf-8?B?L3E2VENTV1R3OE03eXpkaElqb2RuaGxtR1JCQ1JDUVZVTk1oaE43UkV4Qmh6?=
 =?utf-8?B?d2QyTlY4MGZIODg0MGM1M2QxSUZYU3NNQ0FpMHJQZnNUdmRhOFpadGhZWlJr?=
 =?utf-8?B?dmFqZDIydVlPQmVqUzV3aXZVMWYvQUdrZ2VxWGF5Q01PSHJlSUM5d0VqOWRh?=
 =?utf-8?B?RDFPbEVDVk9OdmJVdmg4eWRHUi9vK1hyZlZ2RmRqMi9GZlg0ZGpxejFDNTR5?=
 =?utf-8?B?aEtkelVBZ0k3eUgzRXp3cnprNGtIU1B1SEVoZDVaMnJobHJiMGdHMk00QjZ4?=
 =?utf-8?B?R3dQUVVjNnpVYlF2UERmZkpXNWQ2SFVFaU9Teno0ckxUb1BaYTJMVW95UGQw?=
 =?utf-8?B?RFZ3Nk1mY2lEYmR6RmhRck1YdmZLZXo4RGNFYndzWFkxUzRHOGNQZ0FyM3hG?=
 =?utf-8?B?emU2U0xIUEJLdXY0OStuaVI1YzNNSEZ3MTJvaE9QR3pCcFFJRy9TN1M2Umg1?=
 =?utf-8?B?MGRDaWptNGhuV2FTUDM0N1ZPaHB2WlVZNTdlNFFydHFLbUM4T0YrTTBoNmNo?=
 =?utf-8?B?cEpMWDIyQlN0TTA4MHIvdDhjMEdGejVGYUZkeHcyeWdnWDQxdGdDazZaZlpJ?=
 =?utf-8?B?NjlCK0RhbDdXSnZ3OTRDVm9lQllMaWZrZVpJcGh2OTFac205MVBTcExYTzRz?=
 =?utf-8?B?enJVTUs3UTFYNHJLVStvYkxpc1lDWW9OUlMvZy9tcFI3cEtqUWc3cFZrUjVu?=
 =?utf-8?B?cG45TFovcmpzMU9BbzJ0UVRhblJGQUpySUNxYXhhN20zdWxKT2o0ZzBZREFF?=
 =?utf-8?B?V0hJd2h0RVFYTnZ5Q3JwY2VTMXVzaG42b1YvMHNoUCtoa3ZYa2hIMDZQa0VO?=
 =?utf-8?B?ZmYzV1RzNUxNeFl4K3JNUmNnNjJvL3BmeWpsUjVTZHpkWWt1dVFPWVVFOVM4?=
 =?utf-8?B?dUt3anUxSWFmcnpRZW5TQit4MW1FTXZpSU9rYVAvbU43cEpHc2tta3ZCbDRo?=
 =?utf-8?B?NjNBMUlSZkFnU3RMSzBPNS95YlU5aHpXMHJ5WGtTRkV2dHlvUDNpcHVwSkE1?=
 =?utf-8?B?TTQyMkhKa2NLSzlHVTY4VlZhTFZJRlZIaEJCclNreGZHZVZpLzZ6N0ZMQmla?=
 =?utf-8?B?QXNhb1VFNmpSU0k4MWtjUFgvMlBtQmhSdXl5N2RQUE1YL0YwWHNqam96UnBv?=
 =?utf-8?Q?M8SN8cMtfvNkqO/7YATliuwQx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LN7CAIgBLxYvS3mLsPq+KdgJNx+oRges+FCxlQefvuj++/chVmheIpdW+OQ4ukd0d7FNLveE9fTQRB+UOIWKCVPXBzZi0gXwb9s10XSppzTp1Wa7mPsac48jhDj1HKTg3SuHZwzEkzr2rKYxZ86+5XpjRcxFfLn7CvHQjE8pqH6vK/HpChuhi4o3wsnx3cUrnWNrCEtAN3apuNofsx7s1MIuAoSCqWLrwlhtUmIDYJLQawYid9lIfz5xQI8yX/g7VTLlST2m1shiOBKLtYZyHMJaAQytqTogpPPPvivBVpTXDhqD9uaTptpsSkjiOhFGQWusLZ/AXwCsmjhSLKQLcS49gB2QDzilFNWP2SMUgH64gdKInS8owdL3YIeIQGhLdFLU1zw9NhkG+Ab47EB0uo5kg2KalZCpzFB01NyhdKjGUzutqkRONiW960wSJw/fh6hjtOPtO+eITg++rpOFx7/a7QLQ7prjNc9/RzMYL2TxsqB4Lt32FaWHe0tKI6Dv3GEdIvxS8H89gPpOdU05es8FAEoN2PZEdkD1Qoy81U5L6n3x7Mzw1k4uHje/Ge38gv0rLWpvxzPSyZlx81NeNdfMWcmrLy2asz6fwv5C0aE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2b64ec-6aef-4ce0-4d33-08dc214358e0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 03:27:12.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASZ46QDehRazEpS+d61ang+8TfJdopSSJa90iPXOhTB38AmNlTpZq+CdAbDU0cWIVes4r5g2wBZf18PFk4XqUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300021
X-Proofpoint-ORIG-GUID: tHJm20K3CuX_4YFzo-Yl_MKMzVxjt3mT
X-Proofpoint-GUID: tHJm20K3CuX_4YFzo-Yl_MKMzVxjt3mT

On 1/28/24 04:44, Qu Wenruo wrote:
> [BUG]
> There is a report about reading a zstd compressed inline file extent
> would lead to either a VM_BUG_ON() crash, or lead to incorrect file
> content.
> 
> [CAUSE]
> The root cause is a incorrect memcpy_to_page() call, which uses
> incorrect page offset, and can lead to either the VM_BUG_ON() as we may
> write beyond the page boundary, or writes into the incorrect offset of
> the page.
> 
> [TEST CASE]
> The test case would:
> 
> - Mount with the specified compress algorithm
> - Create a 4K file
> - Verify the 4K file is all inlined and compressed
> - Verify the content of the initial write
> - Cycle mount to drop all the page cache
> - Verify the content of the file again
> - Unmount and fsck the fs
> 
> This workload would be applied to all supported compression algorithms.
> And it can catch the problem correctly by triggering VM_BUG_ON(), as our
> workload would result decompressed extent size to be 4K, and would
> trigger the VM_BUG_ON() 100%.
> And with the revert or the new fix, the test case can pass safely.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>



