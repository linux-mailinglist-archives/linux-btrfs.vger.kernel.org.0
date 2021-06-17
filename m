Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DD73AB3AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 14:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhFQMiL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 08:38:11 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:20161 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231217AbhFQMiL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 08:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1623933362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4h7RDAAKxnEPdTnlqLbhXH7Bu+QSwByew+CxBMiRb4=;
        b=Yb+l+XYBENZ5Jtnmr42XvcK38awglgjHZWep272YepRd5QWKXiSCwX46ivY4WMIo4rxFds
        UTo6IwlhShzhubIxzDgxea6GKoye1nrbqpkmUahK9Rywjb5u3rC7AqVJlYXSLBb2tPbaYP
        tR07TobLVKdLreMJkWVMB3Mp7dJIbiQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-qNkrkbrSPL6kairwoN1mqg-1; Thu, 17 Jun 2021 14:36:00 +0200
X-MC-Unique: qNkrkbrSPL6kairwoN1mqg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4laTSjBmS+kIvadbhp4r8NRxEHUJfUTE/bFd0SF8BrsOZGObgvUjguwqE2UUSUW+SVBFREQ8RU6da1TAZJAD+Zah2FN/MUd2NFZ4lquK4SOMM9cP+aLRMa5UWaqgYRYb7YS2iZkN2zEkgInQdcVxNncRK0I40c3Rn6FSQu+64f+XTREs2UnYegQBBzhJSrnychgwlz0jOdJj8oOsZfgZYQ1gIMci9a2Ip81Vu+g0j4MUWZsHBjktmsHLsFjZT37ex35WZqbLzsi1xYOoRu5ZQoOx6IW0sV9tRals1aqT3UbKIIVaDRFGUpbweVZPuqdC4wcFSn79ibRwS9XxGAzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gWpIye3vClN1ow3ebiU5MJBx3a5OxZEvgZvrlukDLo=;
 b=fH5XOMtmGxM+Td8dgJF0GJhSk60v1hOh9GTPOo4mwvp/R7URvadI3Sx7SLip00RAB8soLQXBHzwxUDLf2pcHwDZbCb4yE1bPkqI8MB+ffDo2PRIeexzNmetk+JL18LDp87ZzYDWtBpnmDwPAtGBbqE80azl5V1I7jydOVrT1w/zJE1wRIuIe0QZVwrV4spFnuXb/kuc8dXfT9ibeTw65PSVb/dUvB/el5wYhMpQTNVt6+62aaQndSQefuzHdWxLmNRypS2ji5RA+25m2jJMUnw5VhX3Osvyor8X846RR0ffpVwmsSH5Zl8zZ/3E6nK8GTrr3QaM3MiImE5alz1Qj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4038.eurprd04.prod.outlook.com (2603:10a6:209:44::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 12:35:59 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10%8]) with mapi id 15.20.4219.025; Thu, 17 Jun 2021
 12:35:59 +0000
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <01020179f656e348-b07c8001-7b74-432a-b215-ccc7b17fbfdf-000000@eu-west-1.amazonses.com>
 <80834345-2626-a0a9-c3ae-fb2cc9435b49@gmx.com>
 <01020179fab66f82-98bc2232-7461-42ea-8194-ec5d1670d9f6-000000@eu-west-1.amazonses.com>
 <016d413c-a4fe-6259-6bb8-b16cb4aa592a@gmx.com>
 <20210617121550.GV28158@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: Combining nodatasum + compression
Message-ID: <6606aecf-0749-d74b-8653-a6ce918b7a8d@suse.com>
Date:   Thu, 17 Jun 2021 20:35:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210617121550.GV28158@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR05CA0195.namprd05.prod.outlook.com
 (2603:10b6:a03:330::20) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0195.namprd05.prod.outlook.com (2603:10b6:a03:330::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Thu, 17 Jun 2021 12:35:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6a68468-ee19-4f1b-1ad7-08d9318c75c1
X-MS-TrafficTypeDiagnostic: AM6PR04MB4038:
X-Microsoft-Antispam-PRVS: <AM6PR04MB403824086753F82800E0AA2BD60E9@AM6PR04MB4038.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6BeIUi60hUioMH9G64kpXHXDbKxfyPiJG+kr4G1Vw8XdeQdMH0qjuqWTHVEkKivX9+BMTP73Gywtik5VJf+CDO5Fz7y3UVemU7BkOJuRVKaFX7gi729u4jV70z19uQv5RtMBhxpfmSwprv0/bUDXGgWv1oqJrzNNcT6SJV9jEJ0YirTsXo7uH3i1G3QwzJoFl1TWpx6Ao+ZZRv8waUrRfNCtj6UTu3/4ib5eUOYmVy1gBVd3zMX+KRj0Ye4lv2fcSIaclkO7kAIDfLtXEgTYVHlZUr7cDIPOuxYTVSmdQmJodNgYJXWoO/jS2uwxNeHcnhSzJAqjPc2Mvdouh9XgUfrSDMYK6hvJdKwhhRXEztX7usoRoCWnEco5IXG8CCOf/6bSbSpCMb4bYSQsMXuswRdneP7Bf1RYw67bAENd8Jx2IOm5GF53jN+ph/GSuiokzyex9y2Ix8ZabI2Uw+4WFDQMIRuvk48cgiYGGUdTpNzI+QFLVFN0LrKlrQ4/2ywPhcEvCJlyS6XLryK0V3Tr7qhfj+dbNrl6PSoDKEpLnr5X3bLiwUL4R5422PD53ru3yEwlyFQfBxXFn5JCuVGPLJDJw7sgG6cm1TAITRSbJMoEL1bNenGSkt6HKQcqfanV5rA7DXA/A9rjAAvu54L4eCy1LGj2f3vurPA1pakjYkD/vulkk5CTJyLkgzts29cdzgd1yieZd4RHX7eMpCcy2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(136003)(346002)(39850400004)(38100700002)(110136005)(8676002)(6706004)(53546011)(6666004)(86362001)(956004)(8936002)(36756003)(83380400001)(2906002)(31686004)(5660300002)(2616005)(16576012)(66476007)(26005)(478600001)(16526019)(66946007)(31696002)(66556008)(186003)(316002)(6486002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ytafF6KW32BAm3hJcNVf7uKVLKWwwdpdafL07MMyMnLul3rAt5TLsPoja2Gs?=
 =?us-ascii?Q?ehIxeffQGb6BW+0u1NPLwPb4Vus9POCetnBzwuwWeCLvT9tBjMADYVO8vcws?=
 =?us-ascii?Q?D63rUx95+VQn34g1IY8kuycbzjOhigIHD0xik0V7c241JdzTHxBjqyIFeTQr?=
 =?us-ascii?Q?Quyx6L7R6t7TAfEmp7rk3cU7lSWHigGzYV+W+uENDQJaotbsZ0iud/03uJ0r?=
 =?us-ascii?Q?duiaaV5atkCWDijVWiddWIo4GdJh3fr2wWrVzC6b1yCDkCOwRp0Vyj2/NWKX?=
 =?us-ascii?Q?M8Uyv9Ojvbb5ysgR/b8nqGGg1TuWYdqb3cS6R4fcnCm372+UoKxfRNFGUvwa?=
 =?us-ascii?Q?muH+6X7ruYSdGbS+XRrJW3tfUFVzYZ6WupIuvhxYY/xhIcdhKxO6hLHuEP4M?=
 =?us-ascii?Q?0zh0cg5HzXR6Z0sNKn7a+Jybjo+C9d/J/zLMPvhx0G8YhjXdKwk8YcMtdCfT?=
 =?us-ascii?Q?NoMCH3dhzF3+sNx0LfoDsb6arx8oRTb11Om4CfWy37SncFZyWON1LuUC61zF?=
 =?us-ascii?Q?e2dsVlVZjqGYUUmiDQ2ZczCiUcGZUaU+GPkRApEn6Ad7hAT+31DG50Q+40qP?=
 =?us-ascii?Q?TIDTYFk7Raipj2e7gsGXSdHjX3sgE/U9odfGOGGhpHdcCiz5smKeQEfoz+q6?=
 =?us-ascii?Q?Lw/yOjdqk3tsD+pz9Qv/nnqpFNJbK0JGWGd2HgAeiI47ob4panMemefEuB1S?=
 =?us-ascii?Q?fcs60A+fyMmfGRlNsg9m+I5JJxSRIiaREZuI2P+ai84OWbINbhC6J5pDdoVN?=
 =?us-ascii?Q?mS02KpFD9HTx/TGmjtWa39hom3Zc/PnFtItDlpm/1uua1o2U64h5jqfqIFR3?=
 =?us-ascii?Q?T4DZm2C3+TTx1HGn1Qqtf0QOI1NCXaPo9fW/jhKLE7GrHOT/dq9xVjFrdM81?=
 =?us-ascii?Q?SxGQb35JV8X9ahRhy8SE4WyhdRkqTzGdr2vir8RR6ndoGtRNA/vvo5yVaOa/?=
 =?us-ascii?Q?7+74BYKKDhECVgkT8bl1UQpo2zxRZHy6YJG3VWD+VTbx9ORnxI+d9+l7CqJB?=
 =?us-ascii?Q?ifbTLVwPJJprb6AGQMMCrqAuCfb4k5HC/3AqEdLWJjZe4sGzBjdfaY2YEuPs?=
 =?us-ascii?Q?Ujr7iPUh559F82trI5CObhjFJrU2Vxg11IEBIZM4sq0KY+j/ZWYdmLgxbAI5?=
 =?us-ascii?Q?Ty6k4jVHiE/1EEW3lGX0Xcl9rGDmzzsNUUOY6iTpA7vy8m+cgFP3hT7/QiBi?=
 =?us-ascii?Q?jF1wkbD/kXnGrAKZHep45OJtW+C22atVKljOaxm+8QPjEakGhzCy9l62JsyZ?=
 =?us-ascii?Q?1wGF3omkbvhsxHELSrGFdoCsM0oCOJZrQoZ2egauHKM3S2Svg1JX2IF6waCI?=
 =?us-ascii?Q?zViC/rJeoEKrsTS9gdQAGalJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a68468-ee19-4f1b-1ad7-08d9318c75c1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 12:35:59.4390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaS5/JKP9MMy1QYCJUgFC+hb3gmg6xfRdCoBxM/NtdM6R+Vc6bCkxpRqpSGLCn07
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4038
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/17 =E4=B8=8B=E5=8D=888:15, David Sterba wrote:
> On Fri, Jun 11, 2021 at 07:15:29PM +0800, Qu Wenruo wrote:
>> On 2021/6/11 =E4=B8=8B=E5=8D=886:55, Martin Raiber wrote:
>>> On 11.06.2021 02:18 Qu Wenruo wrote:
>>>> On 2021/6/10 =E4=B8=8B=E5=8D=8810:32, Martin Raiber wrote:
>>
>> But this still means, all other regular end user can hit a case where
>> they set nodatasum for a directory and later corrupt their data.
>=20
> So this where I'd say give users what they ask for, like the usecase
> where the data correctness is done on another layer or solved by
> completely different approach like reprovisioning in case of errors.

Fine, then I guess what we need is to talk about the technical details then=
.

>=20
> I would certainly not recommend to turning off nodatasum in general but
> if thre's a usecase with known pros and cons then I'm for allowing it
> (if feasible on technical grounds).
>=20
> An example from past is (not)allowing DUP on a single device for data.
> The counterargument for that was something like "but it won't help on SD
> cards anyway", but we're not choosing hw or usecase for users.
>=20
> I had a prototype to do "nometasum", it's obviously simple but with lack
> of usecase I did not push it for a merge. If there's an interest for a
> checksum-free usecase we can do that.

Already off-topic, but I doubt if it can really bring some benefit.

In the old days, maybe.

Nowadays, even with checksum disabled, we still have mandatory=20
tree-checker, which on average takes a similar amount of time of csum=20
the tree-block...

>=20
>> This will increase the corruption loss, if user just migrate from older
>> kernel to newer one.
>>
>> Yeah, you can blame the users for doing that, but I'm still not that
>> sure if such behavior change is fine.
>>
>> Especially when this increase the chance of data loss.
>> It may be fine for ceph, but btrfs still have a wider user base to consi=
der.
>=20
> So the silent change would make a difference, but it's still after a
> decision to do nodatasum, that gets on a directory and inherited.
> That it actually happens is not what user asked for, so from that point
> I think it's the other way around.
>=20
>>> Furthermore it depends on the use-case if corruption affecting
>>> one page, or a whole compressed block is something one can live with.
>>
>> That's true, but my point is, at least we shouldn't increase the data
>> loss possibility for the end users.
>>
>> If in the past, we allowed NODATASUM + compression, then converting to
>> current situation, I'm more or less fine, since it reduce the
>> possibility of data loss.
>=20
> I'm going to read the reasoning again.
>=20

That's because we used to force csum check for compressed data, but it's=20
no longer the case anymore.

As Martin already stated, we skip the compressed csum for read, as long=20
as the inode has NODATASUM flag.

Thanks,
Qu

