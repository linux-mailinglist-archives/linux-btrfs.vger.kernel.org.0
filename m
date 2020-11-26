Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B612C56E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 15:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391064AbgKZOPn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 09:15:43 -0500
Received: from mail-eopbgr760085.outbound.protection.outlook.com ([40.107.76.85]:27712
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391048AbgKZOPm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 09:15:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLvrQvGkaMFzo/OFP76F/mADPZtfC7AaLT8y1GW2waKv6RlRkr500Klr59mIZZSP7FOcRZkWSC3nwR9qyTqNjGadn6Lnb8AUCrOtymt5r6wRKGqL5bbprVCEe6/9ANU/UKmggTy2e+09LgEMKtl7jwN0rjS82EWwzCJT414NQk0Zb08eKkeie5m1LG6oFzU5luJfw3ueZ0rS4jS8q/Pvh8oIZccTDl+Waifk0IREPjTLOWeeTUilP8WRRPzkZjtytLESaErEc0ICBIBnnl7qQNWaIHld5E65dbx+JPmQVizlyMv78KAiA4xwIYEPxipOk45e3MLXRPi1qchWrQGQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YL8NCp/mp66KtYnoBIcm4gIjQSp9q5FB7JTqY/0vH/Y=;
 b=PEq8dNS5zp6AcOX/unFF70CxeRJ/+Kg7Fl1UXfHZcMSpU7kkbAgcVp0gWrMLwvTRr9Phc3vdwMGEJwAiZBHEPFwmTvKivRFca0/EVgE5r+1pmneexYdzpjaNiMSm4adTAgnM45syXJVuBEsqpWfyzrnp+R5zOZDckFNARvu8AUwxOUhAW/u95LWf4PtQU6GQGn0RL+1N0REuEYCh2FiySGolMX2rKjKIYif8eLDrQPpqlOtA3BbFcOn2Pm0g7YGSHDB5alalNM5h2GtAFGXih/2liCB50iswbkAyPL1BXQL4St0SnUSW/5B485W8wygE7GzoycMOpqBnYd2gemyZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YL8NCp/mp66KtYnoBIcm4gIjQSp9q5FB7JTqY/0vH/Y=;
 b=FOq4dDvE9rb+HiuUglmsnaw7PPbuq6Fv/7bGCn9C/d/rNiKwI6G6DZFhV5a2nAemmUUMsSMNNDX5RgDosxNHHuQInKKv0UNrhzCPuq13s60w59co+n21qgXuWRx1FE0qWI22MCPtcJYW3Q1leEYzYC2cJ5hupW8WsBx2bCBjrAQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=panasas.com;
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (20.177.124.97) by
 BYAPR08MB5573.namprd08.prod.outlook.com (20.178.48.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.25; Thu, 26 Nov 2020 14:15:39 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::f8b4:660c:838c:7040]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::f8b4:660c:838c:7040%7]) with mapi id 15.20.3611.022; Thu, 26 Nov 2020
 14:15:38 +0000
Subject: Re: Snapshots, Dirty Data, and Power Failure
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <b58c6024-1692-7e43-c0a5-182b1fae1cca@panasas.com>
 <20201125042449.GE31381@hungrycats.org>
 <60820e39-5277-7d16-f3c2-bca7c3b44990@panasas.com>
Message-ID: <5c7e5a89-08c2-bf61-9adc-0f4d4695bd4b@panasas.com>
Date:   Thu, 26 Nov 2020 09:15:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <60820e39-5277-7d16-f3c2-bca7c3b44990@panasas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2601:41:c500:5110::c161]
X-ClientProxiedBy: MN2PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:208:fc::31) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2601:41:c500:5110::c161] (2601:41:c500:5110::c161) by MN2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:208:fc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 14:15:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3c25426-af6e-4760-6374-08d89215bfeb
X-MS-TrafficTypeDiagnostic: BYAPR08MB5573:
X-Microsoft-Antispam-PRVS: <BYAPR08MB5573256D506CF96F96BA3D21C2F90@BYAPR08MB5573.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJubcY/7W+G53V4/kPbBRZMrjSZY6K+u1SS1JLleHRMG7KlOgY29t84/UqMFxtW0/wlQNXvku65lyJsok4I8LYugqKjBxJRU9y+Krwo3uLi3yZZTSPmLu2B/5UiKsQV1/ZkKAa1up1zfU5NbbUHkVAmBl17ltpkTrHFV6Mv8W9Bh2sdvoFKgx7+GtD5az68fosi7rAtzliMUPH+eYrJdmx8HVR63h9lQBG0mssW1M8aC2w0bElBSQQrFGm2decjg9RowLVRdme12UvLzfOIYHx2jiu7h8ahaOHubrIkDLJBrmDsVB4+u+DafOMBIu9j+nDT6ITW/UbAJse1xyvzOxUKmQeQROiCBIbYqhtYmhbnL9d3WNNisn/yyK2WFuj3n4Z+yUuA1p45L1S8MdTF/Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5109.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(39840400004)(396003)(66556008)(6666004)(316002)(2906002)(4326008)(31686004)(36756003)(6486002)(2616005)(66946007)(5660300002)(186003)(53546011)(66476007)(16526019)(52116002)(8676002)(8936002)(478600001)(83380400001)(86362001)(31696002)(6916009)(14143004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dXZadkpYdlF1TkJlUHhGZzRsQ0RrU0xXTnF6bnFKd2kyRVlkY3U4ODlIaS9y?=
 =?utf-8?B?R0dFc291U3hHUnJvM2wvSXlBYmdQRGVQUmxGRzRhemlPdjVRTUJGWngyVFF6?=
 =?utf-8?B?Sm9GUy9UcXBSa3R2M0dzUE4zU1Q3YlRUTzF4akk2aXRtVEdrUGVKV0RFUnBW?=
 =?utf-8?B?aHJBWWpzNjhzOFBpZ1BTRFl2TlhNWFA0WkxIcDRnNVkwNUs3MFhteGl0MlAw?=
 =?utf-8?B?R1BZd1g1T1I0Y1ZTWllEZHRYK3BJRlVpYWlRbVIyVlVjaUNsRWJNQnFHMEZk?=
 =?utf-8?B?TkpoajA1cDErcUMvNXFJdFREODhTWmU1TTRLbitrUC9BUmd0VzA0Sm1oaVph?=
 =?utf-8?B?L1k0S3NPSUFWd25LVjlEWVYyUDhTeVY3RzJzRXQxbUQyK2JpOFpReFArZzcx?=
 =?utf-8?B?UHRBL21pZjhpVWorQkJ3Mmc3bmhScCtSb2IwZUd6aEY1NTJMM1pORFlGVm5H?=
 =?utf-8?B?cHNOQVBOWmIyM2czb0dpZGxwQ25SdmFEK0hneGdGYndTTXZxQ09VOERETkFo?=
 =?utf-8?B?RERsWTZLUEQvY0VVUlZOelRZY1BJNlloUEh4dHFKSlJmZFJhSElrbG9Pb0VE?=
 =?utf-8?B?WnJSem13R2p0QzlkcUMveUlIaVBIa2E4VE9pcCtLOVZVQnBCTU5NSkVBaUtm?=
 =?utf-8?B?bE9zRDdTN1FWNkxJY3VTSzVLM2lBRlZMclplRE85djIyVkNxQ2w4TzdOU3h0?=
 =?utf-8?B?TFpxN2o0K1JTanlwdHRtdlBGWU5JcGk3bkhGd0w2WUs3MW8xM1J6UklaNVYr?=
 =?utf-8?B?d2pGaWdsQ05QZDNvUUFqVGlabURZOUVHQjhYU0ZQeWlKVlFaVUNSNitVZEFL?=
 =?utf-8?B?ZUpLVXRCSzcvbllBcUVkVU5rSm5FbE41UVNic28rM1hiOUxVaHp6TGpldVZS?=
 =?utf-8?B?NXVmRGdwTktnYzhQZlF0ekl2ek44NkppMWU2dXFMOUM3bFlySVBvTDBLaWRl?=
 =?utf-8?B?ZVdOUm5vOTEvNUNmUmpFS2NXOG1MRy8rRlM4RVM3MVNua3FBaTNnTzZLQmts?=
 =?utf-8?B?QzBteS91clJzem0zV29SWXpGd1JCb2J6Ym9rVk5nQzJIeWJHNkd3ak5JY0lu?=
 =?utf-8?B?ajVtclN5ZlYvbGp0RkJYWkF1b2NrekV1RTIvVndHeDAyendqMjVZL0NLMkJW?=
 =?utf-8?B?T25FbFVDZExFVDJ1c243bWU5VktHOVhlazN1Tk1NdllVUm5TSG1kUlFXYTRj?=
 =?utf-8?B?d21CZXdFcTBOdHZLT1VMU1VVVmowa3hzNitKWGZBeDhKU2VZN0Q4VmxheHNZ?=
 =?utf-8?B?NmFaaWlNNUZzTVN0bTd5NWs2UmR4NEw1d1d5dVh0QlAzL1RKWUJ6Zzl4RDlk?=
 =?utf-8?B?U1V6Y21RMU5XYlgzcVRnM3BPNkY0R1FSNjRVcDR1RmhqZHJ1cG1BRmdlOWZ0?=
 =?utf-8?B?Y05OUVJ3MlluY3c9PQ==?=
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c25426-af6e-4760-6374-08d89215bfeb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR08MB5109.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 14:15:38.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7xrFhFH47GJy/j/5Q8LXlaZPo/+5Yyx1kGBvDKvQAHQ9VtNSS4BhENV/VDwfULcZGyaygWcC6j0xuqhC3Bz0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5573
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/25/20 10:16 AM, Ellis H. Wilson III wrote:
> On 11/24/20 11:24 PM, Zygo Blaxell wrote:
>> On Tue, Nov 24, 2020 at 11:03:15AM -0500, Ellis H. Wilson III wrote:
>>> 1. Is my presumption just incorrect and there is some other 
>>> time-consuming
>>> mechanics taking place during a snapshot that would cause these 
>>> longer times
>>> for it to return successfully?
>>
>> As far as I can tell, the upper limit of snapshot creation time is 
>> bounded
>> only the size of the filesystem divided by the average write speed, i.e.
>> it's possible to keep 'btrfs sub snapshot' running for as long as it 
>> takes
>> to fill the disk.
> 
> Ahhh.  That is extremely enlightening, and exactly what we're seeing.  I 
> presumed there was some form of quiescence when a snapshot was taken 
> such that writes that were inbound would block until it was complete, 
> but I couldn't reason about why it was taking SO long to get everything 
> flushed out.  This exactly explains it as we only block out incoming 
> writes to the subvolume being snapshotted -- not other volumes.

One other potentially related question:

How does snapshot removal impact snapshot time?  If I issue a non-commit 
snapshot deletion (which AFAIK proceeds in the background), and then a 
few seconds later I take a snapshot of that same subvolume, should I 
expect to have to wait for the snapshot removal to be processed prior to 
the snapshot I just took from completing?

Best,

ellis
