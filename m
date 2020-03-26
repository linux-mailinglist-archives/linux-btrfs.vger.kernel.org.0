Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85DE193523
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 01:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgCZA7c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 25 Mar 2020 20:59:32 -0400
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:34457 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727537AbgCZA7c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 20:59:32 -0400
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY m9a0014g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Thu, 26 Mar 2020 00:58:13 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 26 Mar 2020 00:59:22 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 26 Mar 2020 00:59:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWdb5EhZGydhxgOampNj3lbce7+/zE6GjWti149AZsfBcggs99jZAJrGXu9O/WwMG55re6PpQLo6tMFPGmAjIIA74U8lVr0FNttPIoTzZjaiBePfPSw/HtrVoExgbTO7xHahr2eNdq6NmzP1mtyhedcqMGQnSOBzWvm8pS1Sv9pJ45AYMPJ10bJTlVBN0/R9YQu6U5Sctgfej6kQyiNkRo5j4exAfreL2Jn17ctPfbevJtWyYjwHy8m+eoHhMmaFB7T6mIOb/wjVhCEJqCcElymuSB16KKVF3QkvI7s/TXQw2VSfLfShWlMZPF9+7xobrVfFYyqhuh7qwsx8m1AkGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmJDAbeg+YRFSci/15MryDVDQ2uCVAG9ScSG387jngw=;
 b=guPmtASnUcoL0Zz4ry/sPJS29LxKnVHn46Ozn1VBb+uL9w1zxyInjbSpuP++sL57jxRHYttCArx+BzCPROyvq5o23TvyYOtY9ZZUPTkCAaq4mGjAgGj67sn13j1LVlWwlr3xNp17/AWPIWulMHbGijmzF/k3SoAt5jSzoyUF5PknPVD0TXuwMkFLHhwnKwN82WFMQdsPeOsMGKcPpvxnmma3vSn+jIBdTK9m6GR6ptOYcPj2h1bVx/eZHtc2TnTe734XxUZvw4li6+5FJHGebxZU1kpdyV73TBol6Gw69ch3IGg8+RzA4Xjleb/fpY3PiF8ZAhtJ5ksQfelIPOe8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3427.namprd18.prod.outlook.com (2603:10b6:a03:195::32)
 by BY5PR18MB3089.namprd18.prod.outlook.com (2603:10b6:a03:1aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Thu, 26 Mar
 2020 00:59:21 +0000
Received: from BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::2870:1e96:c53e:b1f9]) by BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::2870:1e96:c53e:b1f9%4]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 00:59:21 +0000
Subject: Re: [PATCH 0/6] btrfs-progs: Fixes for valgrind errors during
 fsck-tests
To:     <dsterba@suse.cz>, <linux-btrfs@vger.kernel.org>
References: <20200324105315.136569-1-wqu@suse.com>
 <20200325144217.GD5920@twin.jikos.cz>
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
Message-ID: <b4df0751-2d8d-43c1-5156-4f7eeab5807e@suse.com>
Date:   Thu, 26 Mar 2020 08:59:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200325144217.GD5920@twin.jikos.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21)
 To BY5PR18MB3427.namprd18.prod.outlook.com (2603:10b6:a03:195::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend Transport; Thu, 26 Mar 2020 00:59:19 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12185a5f-c9d0-4d97-3b73-08d7d120ea55
X-MS-TrafficTypeDiagnostic: BY5PR18MB3089:
X-Microsoft-Antispam-PRVS: <BY5PR18MB3089D817639D40B96098914AD6CF0@BY5PR18MB3089.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(66946007)(52116002)(66476007)(316002)(8676002)(5660300002)(26005)(16576012)(6486002)(81156014)(81166006)(66556008)(6706004)(8936002)(31696002)(6666004)(86362001)(2616005)(956004)(478600001)(186003)(2906002)(16526019)(36756003)(31686004)(966005)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3089;H:BY5PR18MB3427.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJ+fO38VPLsOyDhcMsDyPSUvI4eea8FYAWcBMtErpKm/mPxLPE4y7k0jWQwqi14IPR6I/Riivooxf3ym9erVYu6QUtie4/p6NSQiVKonorkkwdcH05RA8p0X5sITldxiDJPj3MCwMahCciiLyHgg+Tcy4vp7CtFqYTbIrcWrx/rn8KySIfWpkm5z3tZC3CGTlhYFIvQJuo+bUq7PAYQH/AyAydaHU+MuitKBbMJI7Yn6rvGZ7HVCQh0zvm2q60DSywITPDcjeKHh9cVA12zhIga+jX6elw9V+DXuP7u5N2xMRs77+7DJ56v0b/yDwyFHJBA+TKxenclua76bLU+csHxcG5SocJIoE0Oemu3xtFYKW91eRmIbARrgHS5SvddTV7otBoIBTEPN+zylhPQhmSjKlJSCSlZbgBZQJ3mnZ0mzV4kNCyv0KvIRsbirUxGVCoWe57Az8QxrokvprC2V2dIz4+Ok7hFhhy/+1IV+vuZfKq2NqjbzdxWlhKFWUJTNS/c+BMtmJt1v5Xcy0YYKX+WgDZgFyq4fvv7nc9NO11DaYI59O/pQCR2q9Fukl6hyESLh4Ev6a7/RIkJFzl4yzDIEEnpSTNHA69630UPPE3wH4ChnvRczDm6h3zLEyjNT
X-MS-Exchange-AntiSpam-MessageData: Kv6DOReCTrhSUfuu2rcNC8o3K2tu4Dj5HaA7zLlTKvI5r19Ayfozx8F5egMMLUBlLzSDJhIxep8YChQf8X4rAoJxVJqNYn/yWwcOCF6ri3cnAys8wfy3f8GmbGe2AILN8WOKrG4zyiJu+y2vJJICTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12185a5f-c9d0-4d97-3b73-08d7d120ea55
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 00:59:19.9426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3N0ag09WUlduIhCXxMA7KsN2Q6EAvPDSOjoiX5DxoxeoJSjAGj8TBkFJSVWYGGMd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3089
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/3/25 下午10:42, David Sterba wrote:
> On Tue, Mar 24, 2020 at 06:53:09PM +0800, Qu Wenruo wrote:
>> This patchset can be fetched from github:
>> https://github.com/adam900710/btrfs-progs/tree/valgrind_fixes
>>
>> Inspired by that long-existing-but-I-can't-reproduce v5.1 bug, I will
>> never trust D=asan/D=uban anymore, and run valgrind on all fsck-tests.
>>
>> The patchset is the result from the latest valgrind runs.
>>
>> The first patch is to make "make INSTRUMENT=valgrind test-fsck" run
>> smoothly without false alerts due to mount/umount failure with valgrind.
> 
> Thanks, that's great. In addition to that, all commands that use the
> SUDO_HELPER/root_helper won't pass through valgrind. For maximum
> coverage we might want to remove the helper from the subcommands of
> 'btrfs'. From a quick scan I found a lot of them and I'm not sure that
> all are required. There's a lot of copy&paste in the tests, so that
> would have to be cleaned up, or we leave it as it is and run the whole
> tests under root.

The root fix is, like what we did for lowmem mode, injecting valgrind to
proper location.

Currently I take a shortcut to reuse current infrastructure, but the
root fix would need to inject INSTRUMENT directly before
"btrfs/mkfs.btrfs/btrfs-convert", so that sudo_helper won't be a problem.

I would work on that if it's OK for you.

Thanks,
Qu

> 
>> With this patchset applied (along with that fix for v5.1), fsck tests
>> all passes without valgrind error except mentioned fsck/012 above.
>>
>> Qu Wenruo (6):
>>   btrfs-progs: tests/common: Don't call INSTRUMENT on mount command
>>   btrfs-progs: check/original: Fix uninitialized stack memory access for
>>     deal_root_from_list()
>>   btrfs-progs: check/original: Fix uninitialized memory for newly
>>     allocated data_backref
>>   btrfs-progs: check/original: Fix uninitialized return value from
>>     btrfs_write_dirty_block_groups()
>>   btrfs-progs: check/original: Fix uninitialized extent buffer contents
>>   btrfs-progs: extent-tree: Fix wrong post order rb tree cleanup for
>>     block groups
> 
> Added to devel.
> 
