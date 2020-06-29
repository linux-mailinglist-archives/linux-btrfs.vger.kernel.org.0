Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A75E20E950
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 01:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgF2XYK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 29 Jun 2020 19:24:10 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:51763 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726746AbgF2XYJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jun 2020 19:24:09 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jun 2020 19:24:06 EDT
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-PvGh9nqSPXy5E7VaSae4MA-1; Tue, 30 Jun 2020 01:17:35 +0200
X-MC-Unique: PvGh9nqSPXy5E7VaSae4MA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbsnMZG/VFGEn//i7fTYDahpMpt0Rcgwv30X4cvZGL7LyKw7FWXMR6BC+uV9fQfg3t5Ev9Itpm/8xBtvCwVtMw8r2WkRrBywn81Tl6KucgMozS+bHo63tBEBS29Kv4CAOZyrDKcA6tWAO/VDcYVd7baQWD36lp9DoaXOwu2w95lvxRR9Z7OIDAvBIPsIFw0+W9TcLS8qEEOBupfkMxMRv/3f00IS4MElMbvA74Iky+IOHP75sEn3OX0/z89PtI/XWo9qPcP/0RW5lja9H8YYYYDYrshcx+PO34HRdbycOOAH3qPIw7SiJJKYO6GllBsNmBJbCzg+DIp6cUiLlaLPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14u1nFReEnVMSssFF8SimDvRsTGpN3DSK1f76bQRmp0=;
 b=DVoXQzbdmzVpp4bOHu6W8lsIbXvTWJ2gol25rt4WfRJCucGZMBxolu6r/Y9ufITUS0HBIs5BbLxaYMEOsgoPTWgpn/WP62tjZfrmlcV5eYMCbVhnL4m+9v/1xYYmw01UnNP2mC9EPr9ZxCT3TNULaJ9XRxJM4wVug3zqohHtoAfl1jbHI3jgt0GINVX65xdb2a16BRcfl2wan9e20j3vkL4oDYuMan+kViMV15w1/3tU4z6qbvGG1snLNJT7DiFmTgx0+yV4iin3IsSSD+IftyJICugx0hH3vD7HWWb1QDlERBmDIcGehE4c28Zur+iN6cxZEzen0ZM8q2q7vvt4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR0402MB3842.eurprd04.prod.outlook.com (2603:10a6:208:5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Mon, 29 Jun
 2020 23:17:33 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef%3]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 23:17:33 +0000
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: add sysfs interface for debug
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20200628050715.60961-1-wqu@suse.com>
 <20200628050715.60961-3-wqu@suse.com> <20200629213008.GO27795@twin.jikos.cz>
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
Message-ID: <9af22db7-42f0-00fd-1a34-33d6a8cffc2f@suse.com>
Date:   Tue, 30 Jun 2020 07:17:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200629213008.GO27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::25) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0084.namprd05.prod.outlook.com (2603:10b6:a03:e0::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.10 via Frontend Transport; Mon, 29 Jun 2020 23:17:32 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72f96ca3-197b-4bfa-0a63-08d81c829a56
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3842:
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3842D225F78657FA2798E043D66E0@AM0PR0402MB3842.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mURpRfoFx9QRYgVmp5eHhPBsVN6a7iHIkazJ9R4n3Kc9xvY2VB4pM588F8qR7M6Vm6iTN040Ahfohjn05SNJvwp9T1kpzN16iTFm+TThgI12rsX1Ui3XG+HaNBfHY+12VF4g7eNaM3cVbUTMjV9lpMNIcO1t1Iyikz8nliAVGU93zDmU1R6GX+zEmvnPidCogaGHtROb2NsAfipNu5K8/R+4mdkYnZFSd63ArsUs4W6t/FhGwHTmuHezIlfUeJyMzqHOrfADtV0CTnubSiWw8oddlwtOiT5Pfn68XRBQWKdmqUbXs1ah+bCspgBFxQqId+xXe8OuoxeIa364s4YvM22xbGssnu4PXxt7+TYrdtfbPv9VbtaYT9iNjPr1K5Ds+Sz5WGdVIMgQmxfxoULxKbh+CsDyD54Vj254P8oucBQOYWSyw0Ku/qL+Rg4zm/fa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(39860400002)(376002)(346002)(52116002)(26005)(8936002)(8676002)(186003)(16526019)(2906002)(31686004)(66556008)(66946007)(66476007)(6666004)(5660300002)(86362001)(316002)(16576012)(36756003)(83380400001)(6486002)(6706004)(2616005)(956004)(478600001)(31696002)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dRyII2juai3kVLzqM4tzyCBejA9bPVjFHtf1/+8VSGFNy0plnFrSibvsxGilzjBecy856Y69JQhjQiNksZk+Tw4q67I7QMZ0k2r1gdZh/Y/aI5wg2yrlaRYvz2z3N6ziNNH4Pi5vhfW0cD/KkCxZma/gX9li1g49NAtFyerrRibvBEwEriWjnu0+qYrIeGwV5Jk3y4UL9+i6Tn78ZswWw/vZ8e2m7eWtMhnx4Mhjk6B1hL9CraDk6AQE+8hlZ/87cQkp6y9Tlo08ESYOtotpJ1Re71vFnD8G10mAR9n5VYTTnZBL9vn43UYrSL6ddGT/nhYoGnBTcVtH8OPOHnlQtaiWHa35XiBsg3sjQWjb6Ct6Om3rVOcCu5sSObaB4uX8j1jJYtw5PBGjny9UnyqtgAlgR1K5a+AOfLE3QVI/VdsH4d54FrA7VufaFh491k5gO+KHO/QQmaFWWxLXJuRQFzn3FSUCP+n7eiiJ/8Uwjaw=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f96ca3-197b-4bfa-0a63-08d81c829a56
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 23:17:33.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juR2Bjl19m2oajkevlzcj/mLaHHXr/kgkPgruHb/yx/8v3yYtCKYxqtr0yGSWGQ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3842
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/6/30 上午5:30, David Sterba wrote:
> On Sun, Jun 28, 2020 at 01:07:15PM +0800, Qu Wenruo wrote:
>> +QGROUP_ATTR(rfer, reference);
> 
> Note that this is 'referenced'.
> 
>> +QGROUP_ATTR(excl, exclusive);
>> +QGROUP_ATTR(max_rfer, max_reference);
> 
> And here max_referenced.
> 
>> +QGROUP_ATTR(max_excl, max_exclusive);
>> +QGROUP_ATTR(lim_flags, limit_flags);
>> +QGROUP_RSV_ATTR(data, BTRFS_QGROUP_RSV_DATA);
>> +QGROUP_RSV_ATTR(meta_pertrans, BTRFS_QGROUP_RSV_META_PERTRANS);
>> +QGROUP_RSV_ATTR(meta_prealloc, BTRFS_QGROUP_RSV_META_PREALLOC);
> 
> The two above fixed but otherwise it's good, thanks.
> 
> The qgroup membership and relations could be added to the sysfs export
> too, but we're limited by the PAGE_SIZE output buffer so the information
> could be incomplete.
> 
Yep, PAGE_SIZE is one limitation.
But we can also go another direction, just using a new dir for related
qgroups, then we can workaround the limitation.

But personally speaking, the main objective is still the rsv_* members
for debug.
I don't really want to turn the sysfs interface into a way to export all
qgroup info yet.


But if this inspired us to explore more usage of sysfs other than adding
new ioctls to get information from btrfs, then I can't be more happier.

Thanks,
Qu

