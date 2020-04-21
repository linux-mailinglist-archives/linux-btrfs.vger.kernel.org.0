Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE761B2546
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 13:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgDULmo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 21 Apr 2020 07:42:44 -0400
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:46393 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbgDULmn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 07:42:43 -0400
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.147) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Tue, 21 Apr 2020 11:40:57 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 21 Apr 2020 11:41:48 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.124.8.14) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 21 Apr 2020 11:41:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfG187hIbwqFSe9ts/+/UGsqtycsXdm9MjpnS1y0f+GYhNgiZqAcXC9LoXUJu1v4gEjcuyiIGjp4LCnEk2vA0HVAgnAwFxQcixGhwAXcw3n2imaatRxYL9293xPNYVzsrtik4AC0m1CM3b38vBFzUwye9t6iXRzUbnqQcnaV2pOnt9KJ5MHuTSa+Tk48ZPmEvuOBBJ0rDJL//ZvYXkfzDeOXKGpzuG71zqqZ7+Yd6wWsFxAGMiI+H7V5QStnxTEbkssKpgBnanLva2EF5rzK7xa7HmUx6zukIDRr3GJEoQM/aXgwwTtfPOrKVEtZq+adO1PiopZ+x6wpI6jFWpVPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJiTyhuBHOW92PZWn7qcqmrwfaogL5ZR/XHIAZmGdzs=;
 b=D6HRWJqTtL/M5VR60icxroYrju7U2OuDM8AFKLkkex/KiP0Dd8iPhT6qYW5se5JjRScVubgJUF6l5+P6LTD0HC1plktkqLYjuwYVhR5nIiEkJHj7yR+jgP17KtjqQ+aIa52YQyHBfjlc4VV2xQgWC7xklRCvfEqbLcz1z5aV8kMSs9UleE67hIHxAuXYPpBgPoWhXtIISX65+nHmnGm2o9QFle+8VHNosQw5OrGXtmU1kGIzBFTjcs3PJR3KzMc/lCkqPrvnEOK9tzN7N5bC7nDkm2WlW1WngOkKiJJkhL157bpBZ6lpLirQtrU/JU13P3ZGBHYGc+/5dOg/UHrq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from MN2PR18MB2416.namprd18.prod.outlook.com (2603:10b6:208:a9::25)
 by MN2PR18MB2670.namprd18.prod.outlook.com (2603:10b6:208:ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26; Tue, 21 Apr
 2020 11:41:46 +0000
Received: from MN2PR18MB2416.namprd18.prod.outlook.com
 ([fe80::8cf0:641e:631d:7a6]) by MN2PR18MB2416.namprd18.prod.outlook.com
 ([fe80::8cf0:641e:631d:7a6%4]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 11:41:46 +0000
Subject: Re: [PATCH v4 1/2] btrfs: Move on-disk structure definition to
 btrfs_tree.h
To:     Christoph Hellwig <hch@infradead.org>
CC:     <linux-btrfs@vger.kernel.org>
References: <20200415084113.64378-1-wqu@suse.com>
 <20200415084113.64378-2-wqu@suse.com> <20200421113138.GA10447@infradead.org>
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
Message-ID: <18832f69-073f-ef74-5ec7-3de06df466df@suse.com>
Date:   Tue, 21 Apr 2020 19:41:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200421113138.GA10447@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::17) To MN2PR18MB2416.namprd18.prod.outlook.com
 (2603:10b6:208:a9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR07CA0004.namprd07.prod.outlook.com (2603:10b6:a02:bc::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Tue, 21 Apr 2020 11:41:44 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2c9a4ee-adab-4504-879e-08d7e5e8f866
X-MS-TrafficTypeDiagnostic: MN2PR18MB2670:
X-Microsoft-Antispam-PRVS: <MN2PR18MB2670FD5AE9552419459ED937D6D50@MN2PR18MB2670.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB2416.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(16576012)(316002)(8676002)(81156014)(8936002)(6666004)(4744005)(2906002)(5660300002)(86362001)(52116002)(26005)(4326008)(66946007)(31696002)(31686004)(66556008)(66476007)(36756003)(6486002)(6706004)(6916009)(478600001)(2616005)(956004)(16526019)(186003)(78286006);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nY2wP8j93NzsGvkpPtmQdkG/feGruZ2ekSjICpbD8rZGP3glXzU8OWjOcbCneY5dnYgNWrqiAQmH4xE+9/z8GG8GeuNOql4UQbIjL0S4CYM1lVLmucReZ5sxo6zYJVtP4dgHKynR+p9uCXelw8i0NBYpjRqjoLrvfBW7lZvyEVMhPSLBX4GhSNTCjxzuE3e/3pKguv6RLgUSuAKvMl5cKNjCHqgziZnWFc9je3eSTVrW9MSgczkZJHI30CS7VrbBo7gY3eWYPE3EiaRvrrOSQNklQhzjx8brtYTi973vPN3AL15ZPvhms5kXoaNxT6yUxM3LeqNRzvTAOSgnf8B1tUoQi4X6jRY+o0LCEVbRyKkLFKUpMSU4UsQ8BaOl4Nu1dhTrlLLwSBhifwS7Jryb8VXvKQ5O708mARrSqeVWaM1PLSyeZGV5YNKFFJgq4d6klXA5KhUtfjwecT+DLHpiID+3CuA3N33D+rqpsFeAclZEmqKkvG31iPtFdq98HYTk7yDxr29jZ9bOzN2r4Kb7fsKsJsNfioqeAZeHvjdzYiQ=
X-MS-Exchange-AntiSpam-MessageData: p/nrKo1TtdCfdJlMDeOeCDecvploeWzgZ8AcB6HqeAIthFtq7cu9wCJGZBmHh1Zlgjr0ri5GUZ6d9FGDbLofQCzcmDslHf0teYG4f8sFjZ3D7/fIMidpu4A7vEy/R/jfoIZAFuk8k1YKg/jZsL8OqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c9a4ee-adab-4504-879e-08d7e5e8f866
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 11:41:46.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNxg6yzo24BWirV3rTO1SNWqj0eixfbCnmERhHJaa/dIzQsMUhoKWcHPz4Qo4kFn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2670
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/4/21 下午7:31, Christoph Hellwig wrote:
> On Wed, Apr 15, 2020 at 04:41:12PM +0800, Qu Wenruo wrote:
>> These structures all are on-disk format. Move them to btrfs_tree.h
>>
>> This allows us to sync the header to different projects, who need to
>> read btrfs filesystem, like U-boot, grub.
> 
> Please use a separate header for that.  btrfs_tree.h is a UAPI header
> with strict ABI guarantees.  Just add a fs/btrfs/btrfs_format.h that
> can be copied into the projects where is needed.
> 
Doesn't on-disk format itself need strict ABI guarantees?

Thus it looks like the perfect location for on-disk format definitions.

Thanks,
Qu
