Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7080154FCB
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 01:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgBGAhH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 6 Feb 2020 19:37:07 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:34281 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgBGAhG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 19:37:06 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Fri,  7 Feb 2020 00:36:26 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 7 Feb 2020 00:35:52 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 7 Feb 2020 00:35:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TD1J4Cj/l1qRcGckcZf+XXITEFkrAOvWWrONxIvisFiNWwLr6nbSRFGaiQaH1PcGwik2tO9wauf3zbYGHlbbUknilx/X2789NaqH1NBjjjwIVlgTvyV8EyZKmGOAyW0Rtf95+3Llu6OAfxtFEBCXFPd5k8Jp9n7hMC+V0hZdXoh4Ch24SClMlVB36GlbYa83fEoSQx0rxxzVK0mZL9T25Y73dMou5Bv1iVuy2krqd03XIFqlSX2MDhJ9DWcddIugfe5z7oYvhgM9xQoMhT93S/b1Q4DJSfDBxDt2+O4sA3FpEwXilUksoFvzufYXbFsRi4dxiXSSjgeG5mjqS6xFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z33mJcFKU/xnlZqh/PKgUJEHgluc4mD60AzNUKApo5M=;
 b=O07WN1B34AnEqzDn7DGnwyHs1gRWrwsbHLWFrBLQaHe++oIYWz2XAUcsfV2wSgW7BHVNEzffUlCKrYH7H6cWgqoKwedMfACAPaMzS96sPVwD6ysZOHac8E+SFOx8wTT6j4OrTGU+dznamN28BHz7rxRz77M0u63RzRMNz7kVrmVfcPX60ONy42tqL43Wxb8M4/54+Pdph6TYvaIFDa261FCAQPLkc3BOfjvhbgaVMiOhDpkPSgoq+IaiGzALrBBxN2vHf/ktPzOoKNM7gvx8DW62wuo/8t8K/EyoRYerbSRt28oIvlUU4Fh9EA1PXFRUMTsY46/7Yo5TCq3IOGXoLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3171.namprd18.prod.outlook.com (10.255.137.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 00:35:50 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 00:35:50 +0000
Subject: Re: [PATCH] fstests: btrfs/022: Disable snapshot ioctl in fsstress
To:     Josef Bacik <josef@toxicpanda.com>, <fstests@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>
References: <20200206053226.23624-1-wqu@suse.com>
 <e3c530b6-af9d-97de-7008-5bc02c77e037@toxicpanda.com>
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
Message-ID: <8199544d-c5cb-eb1e-ed7c-f9b170324997@suse.com>
Date:   Fri, 7 Feb 2020 08:35:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <e3c530b6-af9d-97de-7008-5bc02c77e037@toxicpanda.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:74::19) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:74::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.15 via Frontend Transport; Fri, 7 Feb 2020 00:35:49 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce72bd0b-1614-42e1-5fa5-08d7ab65ae38
X-MS-TrafficTypeDiagnostic: BY5PR18MB3171:
X-Microsoft-Antispam-PRVS: <BY5PR18MB31718943644DEFFAFB9ED26ED61C0@BY5PR18MB3171.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(199004)(189003)(8676002)(66476007)(316002)(66556008)(6706004)(16576012)(186003)(4744005)(66946007)(26005)(956004)(31696002)(16526019)(81156014)(2616005)(36756003)(81166006)(8936002)(52116002)(478600001)(31686004)(6666004)(5660300002)(86362001)(2906002)(53546011)(6486002)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3171;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bK/dlRnryuHcpZu3ePvPIMhzkDzJU2OPmxYVOOpsWegSsUTLMUOkcyRycSLMa9Lv0h4u+yi3Bn8+nGM1tPGZGA01kpABxnK6j6znuKsEdEjc91hXvQy67TiLhIPuPhA3J40ID2iTkYswLB8d/86tjTJT1wek7OKCS7h/ITjzQs8i0t3jY/5cF4H32Coh3HATfYDyBRm0mSwhPFlXNia5ZOneuSGUhD9NGfK/Z/dPRMwgvGvz5PFKYRSjBdD7gXxKdvuUi/gFUrGunJZZ/N49PTTeLUsUvFpdipDCJ4XwsWdd9g5fCITsVNC1Sff0c99qPCAjdxmZoQT3NhZe9TsS1YbEzeggEyUWAO9M3QCpwIvoXxLHxg4FqkXsrrOEUJNYFQCBYYq+vNiYIWfr4whFWq0apM97HzBSjE5SvVNB5CMKceJ3n/j08JMleT+kKZV3RkWLgxezDsW9fEJM8y98YFVWuRJzxSoiNcNtsplRlOSonhKuU6gxuZ6kQEIcqEDOg72TcgghUtmnkOA/G2hTuf8op5+ly/8h4ph8T9Wlm3M=
X-MS-Exchange-AntiSpam-MessageData: J8BUHpYqb0wQPKw0BqNHBLHpDS+CbZHjdX6Rsmz4MW19p5RpQr5QwpuUG8rrOdEV3pNlBFjX1CAMgTmndcLWPATFWoig2J//7/Uh4oxSy+bktPGeSvnA+FFt1U4IhpCSAQGbLf6/KRp3y5EGf+eBDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce72bd0b-1614-42e1-5fa5-08d7ab65ae38
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 00:35:50.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AX8XZTDDF6V3K2N+B4TI1f5sTPYcgfjftb8mNBay958UVgA5MDg6CIvLSYWdaF8G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3171
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/6 下午11:47, Josef Bacik wrote:
> On 2/6/20 12:32 AM, Qu Wenruo wrote:
>> Since commit fd0830929573 ("fsstress: add the ability to create
>> snapshots") adds the ability for fsstress to create/delete snapshot and
>> subvolume, test case btrfs/022 fails as _btrfs_get_subvolid can't
>> handle multiple subvolumes under the same path.
>>
>> So manually disable snapshot/subvolume creation and deletion ioctl in
>> this
>> test case. Other qgroup test cases aren't affected.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Why not just fix _btrfs_get_subvolid?  You can use egrep to make sure
> the name matches exactly.  Thanks,

Because we have other requirement, like limit tests.

If we have other snapshots/subvolumes, they don't have the same limit,
thus unable to test qgroup properly.

Thanks,
Qu
> 
> Josef
