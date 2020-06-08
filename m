Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5F81F1594
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 11:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgFHJh6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 8 Jun 2020 05:37:58 -0400
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:43687 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729149AbgFHJh5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jun 2020 05:37:57 -0400
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.146) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Mon,  8 Jun 2020 09:36:33 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 8 Jun 2020 09:37:09 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 8 Jun 2020 09:37:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeBccXUUA7MfgNBh1msYnEcb3pB13FHGfjCE25RIEp85nPXedGMWNMoZcjvffiAXYKozxDJTx6iO0cudqMt7Xn6XHppR48me1RfQmU1IUXhxH2z5hybwVfPfCBS6PDSF5FGyhstOQdLRDtzwB2Sy5NRbt2mnpbk9xnKd/KslRlh0KyAn3exVa7xyKccQs1zIeTbQzVGrXgoZvwJgYmyT+GXuvzB+woBVwitJa3S8tPVhP/mawFbi7i6uiTu5/xqJlLnUPsNbejVYPY3hTVoRIpegkmErmxO4rsId9bEQ10tNy83GsiBRtfLcGrCd6il4ocjuTzNZutGLxKgqP6ZrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J79Kcv8zOSa5fbL5RLpobNtr9KcyzXcKfXe69gz6Kro=;
 b=exb7UpegmtiGcCr1zvwrZFggjEIwCrvsZk7KTeGTu6cR8s+KSRIKCrT/hCdCzx0udE15pvQgdqkCyiPrnlFH1NaGhoXL7leMIKPAkYNaV2FR/fe8FNDv4ME7CCbTnAkmN9UYiE9kUhWMGMdhDZm/qni4noq6LdQMI6IKkq9LWfHtFDBUuYI7RxSrz9Pc4I8SOrRJ2Lvus6/5rOAUYQ1MdyAN4O0afcP/8VsRwFBwgho2OfTT4h5nULbcQo4fI/voRL6Bnxmirwqu8LlEM5GaLTlW0bndjszg/b9iWBCbNUcHdLlpD9oriEtI2q6WCRW6tvKeEudNcIN/paXwZSrU/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from MN2PR18MB2416.namprd18.prod.outlook.com (2603:10b6:208:a9::25)
 by MN2PR18MB3039.namprd18.prod.outlook.com (2603:10b6:208:104::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 09:37:08 +0000
Received: from MN2PR18MB2416.namprd18.prod.outlook.com
 ([fe80::8cf0:641e:631d:7a6]) by MN2PR18MB2416.namprd18.prod.outlook.com
 ([fe80::8cf0:641e:631d:7a6%4]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 09:37:08 +0000
Subject: Re: [PATCH 2/2] btrfs: qgroup: catch reserved space leakage at
 unmount time
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     <linux-btrfs@vger.kernel.org>
References: <20200607072512.31721-1-wqu@suse.com>
 <20200607072512.31721-3-wqu@suse.com> <20200608072000.GA6516@qmqm.qmqm.pl>
 <4e6fd959-f04c-6c0d-9e13-86942ef47f12@gmx.com>
 <20200608074414.GA1124@qmqm.qmqm.pl>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <57012b68-4a19-d4ca-1a9f-4ae65182f44f@suse.com>
Date:   Mon, 8 Jun 2020 17:37:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200608074414.GA1124@qmqm.qmqm.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:a03:40::48) To MN2PR18MB2416.namprd18.prod.outlook.com
 (2603:10b6:208:a9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR04CA0035.namprd04.prod.outlook.com (2603:10b6:a03:40::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend Transport; Mon, 8 Jun 2020 09:37:07 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71d1cc08-6fe0-4b11-a0fc-08d80b8f8328
X-MS-TrafficTypeDiagnostic: MN2PR18MB3039:
X-Microsoft-Antispam-PRVS: <MN2PR18MB3039E6E03CF88B5B7F10D022D6850@MN2PR18MB3039.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imb7Zl9WYXvcD3WYaXm6nDdhxz+iNB3YePkQtZBEfXF1jWxvxT0yj13JWhiyB7YH7VW7xhT592SrxQI6bgK2KFvGjMsUN5d+kugckizOQL+0iBbVYemTpXogdR4mAUGXoBbn7I5nQAkWWKLC14icqhFw9kvR9GA4NcgGZSagtNKvr+ida0oEWp9SIWmRs2UALuo1bmyfoV3zERie5lIoWXrMAlA7pAGR/xiJoccCnb1Fm7xjlhJwxEHWBb7f2iwVTjAJX1MDLb6RFAQj4gHUEFe0PfnfttAZT1a4dUQQeXUj5sxhNkoG4GdNivrYpsB8Wv/lPO9PA8APNsjTcR8cZGMV5/jAggaoXNZBA1eeguhb1FiGc1DPzBi6S5Ea/VP1f/C4TMaIvWak6tmAaqD1bFmvdBugwtcVJpaFyOaBCjae4TTSkIZD07nzQFzrC/AO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB2416.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(83380400001)(31686004)(66574014)(16576012)(8936002)(6486002)(36756003)(5660300002)(316002)(2906002)(8676002)(4326008)(26005)(6666004)(86362001)(110136005)(52116002)(6706004)(956004)(66476007)(16526019)(186003)(66946007)(478600001)(31696002)(66556008)(2616005)(78286006)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /ukajS7+1kSiULxqpGI4nHzz3gMaBCakmj2Qrjw7xPMRGV5blTuON+WNoT4s6YV1/Cu3+huOJUrdW9ZVOKvqx2vx36dYGp1VZFjGWPS7m9rriB8LXrIx7PhqxmqRyZ7Y+VdzCzEc5n6yaBwy9OAsZYfC/l82USgWz+n/S3SVf3MvYSafU3dfE6TeehTEOTpJJ9ypt2W2+7947tYZ7fB4POpwW6lRchez9GK1upUn2pSPEmRGdMfx5noWCh/7t5HjSF4+g3cpdme4OJNyP5cTJppYnyM2stdDXIhQgqW+KIjYLzw2TVUOLAESrj4HBWUKdpvRzn9W/TOTi0lbI7zgneBE/9+pdZxHHWtmZPe+Q6DGU/t0+hcSdKnpVeO0SmuaR3kxo/tl8eoqPRZlfnHdEPHZBYoXdjNR94xJv89GDiCK0yKvvJQuzba1VY9rVMrVrBMTRb2stP62hyoB6SCOUruKvLi2r78Z7TW53AOqyHc=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d1cc08-6fe0-4b11-a0fc-08d80b8f8328
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 09:37:08.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpNmVrtUYFF0ka0BT9xMCVXd5n2kIXpGv6ONffkCe11PRXOCab/GiDflcfUvTH5d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3039
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/6/8 下午3:44, Michał Mirosław wrote:
> On Mon, Jun 08, 2020 at 03:24:10PM +0800, Qu Wenruo wrote:
>> On 2020/6/8 下午3:20, Michał Mirosław wrote:
>>> On Sun, Jun 07, 2020 at 03:25:12PM +0800, Qu Wenruo wrote:
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>  fs/btrfs/disk-io.c |  6 ++++++
>>>>  fs/btrfs/qgroup.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
>>>>  fs/btrfs/qgroup.h  |  2 +-
>>>>  3 files changed, 50 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>>> index f8ec2d8606fd..48d047e64461 100644
>>>> --- a/fs/btrfs/disk-io.c
>>>> +++ b/fs/btrfs/disk-io.c
>>>> @@ -4058,6 +4058,12 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
>>>>  	ASSERT(list_empty(&fs_info->delayed_iputs));
>>>>  	set_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags);
>>>>  
>>>> +	if (btrfs_qgroup_has_leak(fs_info)) {
>>>> +		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
>>>> +		     KERN_ERR "BTRFS: qgroup reserved space leaked\n");
>>>> +		btrfs_err(fs_info, "qgroup reserved space leaked\n");
>>>> +	}
>>>
>>> This looks like debugging aid, so:
>>>
>>> if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
>>> 	btrfs_check_qgroup_leak(fs_info);
>>>
>>> would be more readable (WARN() pushed to the function).
>>
>> We want to check to be executed even on production system, but just less
>> noisy (no kernel backtrace dump).
>> Just like tree-checker and EXTENT_QUOTA_RESERVED check.
> 
> In that case I suggest:
> 
> btrfs_err(...);
> WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> 
> as I expect people look for messages before the Oops for more information.

Yep, exactly what Nik suggested and what I would do in next version.

Thanks,
Qu
> 
> Best Regards,
> Michał Mirosław
> 
