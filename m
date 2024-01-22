Return-Path: <linux-btrfs+bounces-1586-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 512FF835929
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 02:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762381C2182B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 01:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E9F139B;
	Mon, 22 Jan 2024 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O7swRrJZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gFK5sWt8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2921A29;
	Mon, 22 Jan 2024 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705887375; cv=fail; b=tjQIQ9/BQYxR/OG8SPplindo+gIE6BCR6e4AbBGtk45gdudRX0ZMooitSOgBO+iGuzfJYQmmznBhIeOOf34GfIbcHo/aPxIXaJms3xm22ILB8PTAbK3BZLYAUdDv7CPAibLMoQOcQbRkgSqCGa9aHtRHDEwjcZRDfbrmOdohzwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705887375; c=relaxed/simple;
	bh=HSBkjac01CeV8a6Jjc33QOL05gkiUkRfOMfRNck3wxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CbwkE/edWHW3DyPhAJL+28TWrqUr0ifYjS/FSk0U0wzBaT+r+c6hdTn9EXA6/G+S38Xt6fsh/eeeDrPow3Yy5o70f4bFyPA0H18/JsjEddbWFX8lkNk31t563+goS2uypTrEomXrHtVlcqrqZu8pV8E+Y5y/fUf4eDIfoFChkgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O7swRrJZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gFK5sWt8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40LNZOW0018034;
	Mon, 22 Jan 2024 01:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=yfi6WZm8tb1hOpdfUGJUY5yGqSsYUlqBLPKNlo2zeSY=;
 b=O7swRrJZObE2YfHDOxShcrtqzVeG5D2Jre1pAV26x1yeJ5fvVe4jb89BFGXpI7IzgluG
 FRsNwXV4SRQbuI2/z7jNCgggOCKEBzZWisOBnd91pX0XPRRaIzSEmggppPSxnnACUWU5
 TgydJuQQZfUakIHhbKmc5XNwHqlGhppyhffwUdavQO44XDvpFmK8kHwMUrGq5vgCykJQ
 NLTMZ4DFk8ZgJx+wGePnNjWEO9qfIXzbPlsGU2f6MjmmiAUenG7FeLXj5Bh+/qjNgXEC
 bMIcnckNelLZR3JPnL6a4ZbJoAbMwCLT3xLjOTWzfn3hkDpJAm2EFf8vr1HKnplZueNU Qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7abtcy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 01:35:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40M045bW040348;
	Mon, 22 Jan 2024 01:35:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs312xys0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 01:35:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Inb9YuZjUunVzb/nflccmi/bmS06dpmHzkDhq8Ldg2z5ADzEDNXMZ1/d251J0J46Aty6jmDCgOY/PzYNNyaWamgKYSgLNFmpYwGXqPqZX4sbYED6jJtpToHMvlJqkol6vjr2lA6/WbTKAnwijnfS5rAVtSRm77rdVP4KoTzB05RO+wyWGNa3KZmdrxdPFx6HixJSeaTFeniZFf6rAgRAnSp143tBMc2A80JJcUlpWKQV1QC1+uOF6GPS8ckOBShqprDKLyvqkJ2qmpZ+GcFCZ9c3T8l0RexaUONZAvLlCZKSS3j7qniD0Dr21EBh0MST1bqjzhDdXM9aVhZ+SzZGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfi6WZm8tb1hOpdfUGJUY5yGqSsYUlqBLPKNlo2zeSY=;
 b=Sa9f6Etn8yGt8ahbOcq1u8Se4BvIWCPi7OCzs7OV59vuaSyFN2Wac61kqSeZBvJOv6c40VbdCkvg7f9xPgjbw6wliVNSa5bxmEPvHnqFZVuaE55cgTyHkSxdWInlttCmVWWRe5p9JbRDSdI2byiTtX+i7iX3hBNupIfHdyy1OLLkjZXGbyJcX7i/QTTiD3684WSM7BPKNhVihzEXIHyAwZxx+IlLhi+g386+N5qeggGadR3SQwkETEhjrfWBHOZ3MCzc3tX6F5fP1ExMpku+GWvS+WtZGuTwWQyD8xWNHJIZ5l24bTGENeYVKjojau3+BA40cUofPbQe85jyjL3njA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfi6WZm8tb1hOpdfUGJUY5yGqSsYUlqBLPKNlo2zeSY=;
 b=gFK5sWt82UUIL829FX+DezJ9DJ/2bM2GStxg3xE85Blklk7M8RjL9sgS8lZWegRbmnKce3xL0riYQO7bF0HC61QsfuAJmzF0O5RK9RgtmuhoMheTxcf25V0KdBgN8dHPLxqYlv+4d+kuMlH7j9edwpz2ExO9rjdgtaKT1bk+Q6w=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6780.namprd10.prod.outlook.com (2603:10b6:930:9b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 01:35:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7202.028; Mon, 22 Jan 2024
 01:35:28 +0000
Message-ID: <7d28b18c-3477-83ec-ef89-cdaf6ca7ebee@oracle.com>
Date: Mon, 22 Jan 2024 09:35:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [btrfs] commit bc27d6f0aa0e4de184b617aceeaf25818cc646de breaks
 update-grub
To: Alex Romosan <aromosan@gmail.com>
Cc: CHECK_1234543212345@protonmail.com, brauner@kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        dsterba@suse.cz
References: <CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com>
 <39e3a4fe-d456-4de4-b481-51aabfa02b8d@leemhuis.info>
 <20240111155056.GG31555@twin.jikos.cz> <20240111170644.GK31555@twin.jikos.cz>
 <f45e5b7c-4354-87d3-c7f1-d8dd5f4d2abd@oracle.com>
 <CAKLYge+x9kxLBaJGyk_gTMK2kQ=+Lhg00jgXe=P=jmBUq=cmfA@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAKLYge+x9kxLBaJGyk_gTMK2kQ=+Lhg00jgXe=P=jmBUq=cmfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: a6913e2c-9eae-4cd5-3c67-08dc1aea69ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WH+PMgH55Dg73UiCykPXie2XfxNwOlGLI5GzG5F7b3gXxwhT9MlH2PF5npdyrsUSuOW64d7K5YGeDsnvTU8r4W5wN0u573FOyAHmR/nIQqOrWAJNWroFgYLKjv1HJrdwLhImlZJJ10l3/r++Xe14VNou043UygMsCYFWsiMO/w43Ck/WQT+HG0H1NfK43Tmbwqd6eOsAKV/ZMJQ1xO3lbMgSIhRGALL/eLLMTS6r04bbf58ja6iA7+iaLB6eHw5VAnxzkpMyHDXRiTN6d3YBtSBe1Se1cIkMKhi3yX1fzEwibIt4m11/xXQNlEfzHvxHQVayhfU7d5jwlex6Nhw3QkxFlEhiHV1l8u6IBQ05b54EFsVp1lc3qTmD0WadX6h6vxqNkpsMSGUoqCNJq69D0VNU4t7HdNwD3KhiaYpdxzE0Z6+47QBJoI/rAwjtFX6JCHUFwcTAI6M7+D2kPlqE6bTOSK8x9i1GKV7g9KUHw43mY3r9R4gN0EXex2kExS+cmUAR1uo4ZvXKmZsgogJ2uPGEB6A7HDlHj5+8fZp84sk4prDmn9gF+fZ3LH0ubmsUzSZPO49b01EgLs+chz4eeu62iiEN1+G096wQdUvuNFpEoY/P5fxbfNscf+EmDnQ97i4mijrcuKcTBxsJNhzI8Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(6512007)(6506007)(26005)(53546011)(2616005)(6666004)(38100700002)(36756003)(86362001)(31696002)(8936002)(8676002)(41300700001)(966005)(44832011)(4326008)(6486002)(2906002)(15650500001)(83380400001)(5660300002)(7416002)(316002)(6916009)(478600001)(66556008)(66476007)(66946007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?di9xeC9zekhMNHBXemlqUDhFU28xbm9ySnBCbnk1cmFzMW9XMW5XRXFicUVm?=
 =?utf-8?B?QjJyZ2hDZnF0S0NuM3lrdW9RNjZLM0tRK0JSWHNKSTBkYlNIazBzZm9Dd2J6?=
 =?utf-8?B?dCt0eHc5aDBvdXFxOWRRZlZDNkVwTVlHK0tHbE9hV0xEM1VSVDBGa2FnWUNT?=
 =?utf-8?B?VVFPQlN6RHFRUWRyd1ozdzluWTIreDhRenlZY1NFa3FYQWMyRWZRWkM5d0lX?=
 =?utf-8?B?a1R1eE9ZQmltc3JYSk5XbVh1RUhlSlRiNlpnV1NrenRDUGxhT2FPcEZ6TW0r?=
 =?utf-8?B?ZytDN1hlOGlyMUZqNndTbmFQR2x0TUg3VzVRemxDbEhXS1IvWWNaS3FmSTd0?=
 =?utf-8?B?SUUveXU0REtud3lmMUNwQ0VtRWtpb1U0ck91a0NBc1Ywd01wY2J2TE81eXdN?=
 =?utf-8?B?WGg3WlBSeWwrNVVDaTd3NUhYWTdNQk5rQTZhTG5NOHJaSzNHbmxXbDgrc2Zm?=
 =?utf-8?B?QXdSWXlpQkxUVUU3V1BRYW1kam0vbEF4cDIyZDN6S2VFcWRtUkJCVSs4MDFs?=
 =?utf-8?B?eXpyRmZxVXdrN0RVdUVEOFdLUWRxaWRZWmtUSHhLVERjYzh4MU8zbHo0MEQ4?=
 =?utf-8?B?bHJDWWNTc3NZYTU1dlZOcDIvMDkvSjhVcmIvRlVxL1Y4SE81VGZwNUJqM091?=
 =?utf-8?B?MzRDZkNnaE9QQVJnZHp5RUFJZ0VIR1hPcUZSa3kxeFZYUldQc2g1eGFzQVE1?=
 =?utf-8?B?ejBvWUxJaUhRVmxUaEVZb1d4V0NyYmhlcGhTK3VaY2t5TnQvSjREVHhDcmEy?=
 =?utf-8?B?cUNHMi9UVWhrb0xjWFF2T0FsTTM0TjFHN1lTcXcvUitDNFptc1ZaeGNBWG5p?=
 =?utf-8?B?dHMvZ3BpcThnM0pRc2t1ZHdYQXl6SVBKN25hcjhncjFPUXBQK3FWSzJnRnRX?=
 =?utf-8?B?ZzBEQVcwV08vZXFjRGkyY241LzQ1am9rRThKVlBvTVk0cGlmL3dGQVVrbStl?=
 =?utf-8?B?UG1WTTZrdDBsNFVXZjgzdWxEL3U5RmFma3RMbXpFQ2U4VDQzYXVENmZaWXQz?=
 =?utf-8?B?UDBqbWIwSi9rU1lYSDB5V1Uvdjk3OUpTc3IxSVVBVVk3TXVlQndsTWdzaFpR?=
 =?utf-8?B?RXptWlFramUzd3JhU2k1aUd6NEN6RHR6cWQxK3BxemRBUHZibURMZkRROFgw?=
 =?utf-8?B?N1ErdkZoenJJamdFZFFKNzcySVpWOEMwb3VNTysybGsxdUFKVEpyUzRabDQ1?=
 =?utf-8?B?dGxObXd5VXNMQjhqT1d2R3JaZU5vT24wMTlFYW00Uk1QTTNWZEFOZ1AvVTJu?=
 =?utf-8?B?Q0FSWlBtNCtsK1hzSllmUDdRZTR1MnU5RnkvV1FacG9DUi9TMmU0MzJFZEJB?=
 =?utf-8?B?UTV2M2dJcTBmNjBJclBrRjloQUtEWmt2MmVnQ2FDb2F1Q2tJSDA0TVR6RlVG?=
 =?utf-8?B?dGhyTmhtMmoxcm84WmQvWmo4UXZuUzhsa2l1WmRZOVllVnNUQUxnU2hOMW5L?=
 =?utf-8?B?ZTV0bk9rYmtseWM2elE5RXRTMkZZVXA2bDdHTW5ZalVGSitXaDdHT3JMNXBH?=
 =?utf-8?B?NHkwQUF3L042R0JIdDgyQzhjVUFGSUw3WHZKZ25WSFNmaFdxT0dsMFV0TTd3?=
 =?utf-8?B?dzBsdzdIT096Qm9WbHRqSVAwNktsZ25DUHc2WXBSRW5reUtrN3NIcFk3Tlda?=
 =?utf-8?B?L2ppaGN4cERmUHBraFNiZXlIZ2JRWkQ5QnlEaysyNlYwbndUS1ZBam42OHVG?=
 =?utf-8?B?WXlVZ0tNRmQ0cEExZjE2ckUxNVF3SXoyT2hReVVpL3I1OVphTTF1YTQ5eGZE?=
 =?utf-8?B?YW0vQ096UHhRUjNNVGF0Q0cxckd0TW8xSkNVcWxTc1JVamhyTXpmd0dxWjFy?=
 =?utf-8?B?T2VqTmE1RkxmUktFcnVLNmVMa3ZzTHRVaHRzWE41OURGa2pGRmEyOXZBZlFr?=
 =?utf-8?B?S2tWbkx6MkN5bWhuRzdvajVJaTZMTXAweDZYTURTNEpmK1pGWW0yNm9uQmlv?=
 =?utf-8?B?RC9nUlFjQVFISGI0OVN4L3pUR1dBRTIxdmFkc1hPRUVPVjkxMnJxSHFRblJu?=
 =?utf-8?B?ajhuV242WGdGNG4zUzFtemIyMTJRUmxWanpLUkRJbDJUS2l4QnBqem5rbkFw?=
 =?utf-8?B?cVFNaU9naWlnQ3FqajEwZjRybjlQL1lWVXI5bzMrTUk0R24vcm9qT3Z4eGJ3?=
 =?utf-8?Q?SlrSZ/Jc2ZYdyM2EXoESTqrXM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ytMdvdiLqz2h4mEj7jpScQHRXIiUBRDCbBiW2X4OrGOYsFyxiWqfWBDcb30SC9TA00zroS1iS5ZOHbxrG5P4zHRgHMQuBiC8GVSRddElt+5FyKBXbvwxFaNUSyH0TawMIKQTtAd8a8j/gKi+5F6XIQdvSHgk0w11tcLDOySmtH74PWzBkEnhkLS+I+QPJpX0AHPZz6H7ebyxOBZkCP3MRohojpuqLJQGM2fcf6jORXkSR1RsAp3AYqqryL2PzkVssgitjWbDH9kNcPvnTGMBalC48A+GuVIYyeT9kWOs9n82c0/KZMPSpKvnLwnEDsED2kI/P2E8fs1/7emI6KCT9b67rv0RjGCwWka5db1DEgnR5ockQwk2vf8e7JLd3eZR6YlERV/ui/OftZldpvIg6wh2xxF5fvQkFa5/g46lSboG9GrYbThYf9S7tcDqEm0htgwb36zmgiu3274vjO50pI21oEDF1HEjyXxu4rIznRyfH05X57WJkEBO7MsfPw/t+Uxu0W20GHqxkNPXGEP7DD3uI2Oa9pdRNq7jGtX5qBWufvkN9CFYYZFYtrhTOR0058Hu+Cpn96TVXKjJGOh2DJIZ/oUXBNLzoEjrbLl1kQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6913e2c-9eae-4cd5-3c67-08dc1aea69ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 01:35:28.4320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFOCHo5NtKW9brFB6rUQAph1QuBOxCWOxSIEk1DUSE9EH6GhGt/+Yq6+itCxUbhhWXHc+MBD8RbQPwcc0yzXLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220010
X-Proofpoint-GUID: zs3R0LxUeIJwo_QYiTfXIKcXD177Ri4l
X-Proofpoint-ORIG-GUID: zs3R0LxUeIJwo_QYiTfXIKcXD177Ri4l



On 22/01/2024 08:07, Alex Romosan wrote:
> update-grub still doesn't work 6.8-rc1
> 
> so i did:
> 
> # cat /proc/self/mountinfo | grep btrfs
> 21 1 0:19 / / rw,relatime shared:1 - btrfs /dev/root
> rw,ssd,discard=async,space_cache,subvolid=5,subvol=/
> 

The latest Btrfs kernel expect one MAJ:MIN for a block device,
but multiple nodes here point to the same root device:

   /dev/root MAJ1:MIN1 \___ root-device
   /dev/sda1 MAJ2:MIN2 /

To fix, I'm exploring communication through block-device nodes
with a temporary signature tag on the superblock for identification.
Community feedback is pending, and potentially synchronization issues
maybe a concer.

> the difference from your test case is that it doesn't reference
> the disk device but /dev/root which on my system doesn't exist. could this
> be the problem?
> 

How are you reproducing this? I tried with Oracle Linux (OL), Fedora,
and Arch Linux, but they didn't show /dev/root as the root device.

Thanks, Anand

> --alex--
> 
> 
> On Fri, Jan 12, 2024 at 12:24 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>>
>> On 11/01/2024 22:36, David Sterba wrote:
>>> On Thu, Jan 11, 2024 at 04:50:56PM +0100, David Sterba wrote:
>>>> On Thu, Jan 11, 2024 at 12:45:50PM +0100, Thorsten Leemhuis wrote:
>>>>> [Adding Anand Jain, the author of the culprit to the list of recipients;
>>>>> furthermore CCing the the Btrfs maintainers and the btrfs list; also
>>>>> CCing regression list, as it should be in the loop for regressions:
>>>>> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>>>>>
>>>>> On 08.01.24 15:11, Alex Romosan wrote:
>>>>>> Please Cc me as I am not subscribed to the list.
>>>>>>
>>>>>> Running my own compiled kernel without initramfs on a lenovo thinkpad
>>>>>> x1 carbon gen 7.
>>>>>>
>>>>>> Since version 6.7-rc1 i haven't been able to to a grub-update,
>>>>>>
>>>>>> instead i get this error:
>>>>>>
>>>>>> grub-probe: error: cannot find a device for / (is /dev mounted?) solid
>>>>>> state drive
>>>>>>
>>>>>> 6.6 was the last version that worked.
>>>>>>
>>>>>> Today I did a git-bisect between these two versions which identified
>>>>>> commit bc27d6f0aa0e4de184b617aceeaf25818cc646de btrfs: scan but don't
>>>>>> register device on single device filesystem as the culprit. reverting
>>>>>> this commit from 6.7 final allowed me to run update-grub again.
>>>>>>
>>>>>> not sure if this is the intended behavior or if i'm missing some other
>>>>>> kernel options. any help/fixes would be appreciated.
>>>>>>
>>>>>> thank you.
>>>>>
>>>>> Thanks for the report. To be sure the issue doesn't fall through the
>>>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
>>>>> tracking bot:
>>>>>
>>>>> #regzbot ^introduced bc27d6f0aa0e4de184b617aceeaf25818cc646de
>>>>> #regzbot title btrfs: update-grub broken (cannot find a device for / (is
>>>>> /dev mounted?))
>>>>> #regzbot ignore-activity
>>>>
>>>> The bug is also tracked at https://bugzilla.kernel.org/show_bug.cgi?id=218353 .
>>>
>>> About the fix: we can't simply revert the patch because the temp_fsid
>>> depends on that. A workaround could be to check if the device path is
>>> "/dev/root" and still register the device. But I'm not sure if this does
>>> not break the use case that Steamdeck needs, as it's for the root
>>> partition.
>>
>>
>> Thank you for the report.
>>
>> The issue seems more complex than a simple scenario, as the following
>> test-case works well:
>>
>>     $ mount /dev/sdb1 /btrfs
>>     $ cat /proc/self/mountinfo | grep btrfs
>> 345 63 0:34 / /btrfs rw,relatime shared:179 - btrfs /dev/sdb1
>> rw,space_cache=v2,subvolid=5,subvol=/
>>
>> However, the relevant part of the commit
>> bc27d6f0aa0e4de184b617aceeaf25818cc646de that may be failing could
>> be in identifying a device, whether it is the same or different
>> For this, we use:
>>
>>        lookup_bdev(path, &path_devt);
>>
>> and match with the devt(MAJ:MIN) saved in the btrfs_device;
>> would this work during initrd? I need to dig more. Trying
>> to figure out how can I reproduce this.
>>
>> Thanks, Anand

