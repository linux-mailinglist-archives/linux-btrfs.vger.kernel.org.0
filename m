Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAA23C4AFF
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jul 2021 12:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbhGLGzT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 02:55:19 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:22185 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239308AbhGLGtk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 02:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626072410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUyhYb1bp29pTnNKErrCiNJ8gUwa76Y2EAJ7+0HuutI=;
        b=DHNkBIVaastGkkO3wsZO42MkZ9O2LbdgN0+7iqilUNR+mExy4ZXR0gPjm6Krz2W3/JqgwG
        j15HCJNfrjeiJwn+boN30hB0spGNWu0662pbvXaYiu1NJyeC/8FK3auvK8kP1CaLoASIDJ
        VwZApHUrE5uWGkrgyfnEZHU9ti069hs=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-35-X84y76VMOxGvz-Z1JUhlaw-1; Mon, 12 Jul 2021 08:46:49 +0200
X-MC-Unique: X84y76VMOxGvz-Z1JUhlaw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMD8afKmWIg3xCQH1cmvXCdPH0zRR/fUaSvi6OllNwzQ6lqPP/2HSQQ2V+waGxWyAm+cFHzAIRlMmVx/BpCHMrsJUCeZ2kmYlnmeBJaeoIIAV3JvQJNSOq3EXSuumkn3rpqjrSIq7RL08SPn59gL6f+66lkUZ0fG2ITWOeDBIy6uhMFuzgYcYhn9d4O3VmEtWfS/wmKZVehL7ydURgzqFl/0FWpsQ/MjdgSoe6m8VLUKIMl3jNxP+V+Bukqp6HuGkDYcXCZFMG8/qomeVUOm2PgjCtA1WvhJVV4LVq4BR1iHuDtJO1DECYIAL+19lE+ew7Jnu1XDDlnaz9fO8ipNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytMlV0N8qY/GyK/SVgTSQV+fxdJOy/pgHBhJ8bqmWcA=;
 b=Tob5MOtt4X/Oj7jlwiIAbFCanmFVZYXkmKTh0Dbrjw5vmzGUl2uZ8WPnbZ++JvmdRvXCkgCIk7uTBIT4RF0Telh8oZeG+zLx1yciX8VMvEkngG1hmXGbMX6wAHo7kvE6luvqdwtHMmT1Lsmn/H3tK/mpOlDWgdg8kaMNhlO3zDj9+7m8PDsfJiK553TcMrjhKkWKbAzHOms56rszWb8SiiCgOIrgMVcj6SipbMK5KzMCnEecClfLFFZ0lxYve6MRlGLtJwh353ztB3vMnoCXtLT0C42rcgiHhNWPMxP2wCt/mZsEki8LUlDkFS/6Hk65Bs3HtWWm45IBtHlh5oEQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB7671.eurprd04.prod.outlook.com (2603:10a6:20b:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Mon, 12 Jul
 2021 06:46:48 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 06:46:48 +0000
Subject: Re: [PATCH v2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
To:     Sidong Yang <realwakka@gmail.com>
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.cz>
References: <20210711161007.68589-1-realwakka@gmail.com>
 <20d7b0a8-8e1c-c13a-6a94-525a110a6b0e@suse.com>
 <20210712064008.GB68357@realwakka>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <933cc012-1b8e-3d5c-d8ed-76e81f461d34@suse.com>
Date:   Mon, 12 Jul 2021 14:46:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210712064008.GB68357@realwakka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0133.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::18) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0133.namprd05.prod.outlook.com (2603:10b6:a03:33d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.11 via Frontend Transport; Mon, 12 Jul 2021 06:46:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcc44691-c553-49c2-4013-08d94500d24b
X-MS-TrafficTypeDiagnostic: AS8PR04MB7671:
X-Microsoft-Antispam-PRVS: <AS8PR04MB76711299700B77CC77A0E7A3D6159@AS8PR04MB7671.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F27K5KTkkJPocx0PHezYNjvzFvgjJgBxYq374dNvXF/2Bq1LXQNWm3InoOdUGgyNE6i47hNU+EcohvNL6D6Il8SEwD2wVp/t2rXWcLhg9QHnRtynE00Qzq6ROxJg5ECnIuGKLHgIHDe0HZqDC2S+FOZUDNBooJokSoOpYOxVcxiVSi1PVSPlYPkEgv3Vkw2Yh9tpZp8Or5hSoRMwsvaPUG2MDhB5IyDsjp/Hy05qvYBQd2geKsJhZJK8EYAcJAkC8vnfDbipx9xZi6LlRKzMJvfbl2qdWDn1pQGoAmJctS6H3fu+cCqIUdpPm0wnoJ0NuQbmhD8q5iG2QgSDgyc4HP14WjFyh3wJAQ4mYjmX5AsUWCnmDW3XL5Pj52ItFGM/LJILtKYewzNYp9yhogU6vAp/4xXHOiEYTUK1eKj4Ew3BChQZ61MG47sk7Qs5n/h00qv+t8Gb01ajZvK16kyZ2dTBfCp/zor9VyVhN/Ldw31pFx7xcMoVPrQhqeQiTJJZulQYRY/t4J5O2WnSKOOUGkyZyfplqfkVrbcXcDN2JCqVvee5pbFebuvUVZJf4xecV7tRaexRL1TEQs3tHdXm5/hBJJ2W/PN1TnmH2B0MYHacCTFJl+OwZCaq5URbafQN72nI+8Gv77AWFAJ6RhpE5nl5OUFOp/SOwoV+HGic3fU+Cj8HRTZlARNV+BCmmxakMmP5fUrQ+jwMVsb+7yVoWLkVYQtv17j+w71owPBHkjWyC8tNY+Cll9P+IniJxITSobOfHn+s2tt5jQUQLWlMQVpaL15HK4tP2BhonGn2lf7InKkwpGfAKrCyXd2ydQ43hq8Wn11RwcXStDildsDeJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(36756003)(66476007)(66946007)(54906003)(66556008)(16576012)(31696002)(6706004)(38100700002)(6916009)(4326008)(31686004)(316002)(86362001)(4744005)(6666004)(26005)(5660300002)(8676002)(6486002)(966005)(8936002)(186003)(478600001)(2906002)(2616005)(956004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a2xTck3aceGA+J/i0Gle0g3jjmDxcSm7kAH2w7CpaW2ajPdFOTPm5jb/mE1P?=
 =?us-ascii?Q?GikteJggLQvVFbMPMNyGnaVDzYZsZJahGJKMY8CBi+JKsn1BgAoi0dfHoQxl?=
 =?us-ascii?Q?iJjMOomEBeQa4yr2rBOXXs9VEvOfCzBgeQ9cWZJiTwjh3IdQOPNPjGl99lmX?=
 =?us-ascii?Q?cANbswjBI6Ww7FgXqw7ZdSqj0xMtey4QDlEadnjqQDFaC7LESKduqrM9oxLe?=
 =?us-ascii?Q?gHpHaAkuxD6GWc1y16ZkEuR6CpDOVJcRertnZXTa8e4e6DmhHn2Y4lomlzhw?=
 =?us-ascii?Q?jwVL37bg8gipRP6JqLc95H3YkOycqaIsj4YJYYyquvcAcem5W5CnKPcuhCqt?=
 =?us-ascii?Q?Oto367duygkaZ5iezU7pzbCvGaojN6QZx87HfnD4E7HN7UiG5YzXYvVYC4+R?=
 =?us-ascii?Q?psHQC9V2H0Tvc6+55lh6XGHi1j4kUL1qwacbGk6lnFYUc6ihWGFPHo1m9Txd?=
 =?us-ascii?Q?5jAl7RfeiXSus5wvH1GDn8JiLrcjCI1iUuDMjGjcoeTKnk++FU00LD3/mWin?=
 =?us-ascii?Q?abgEZh/SnJR6pqZhkebxAfi7OkofPGDhChSfUsDxIEN+aqJ3IRgxwozqNlB7?=
 =?us-ascii?Q?fcjt/QtTG11bABTFro9kOW0jDLkUzD/tS2J6bW6kjERqMqNwriUE+gOYdE4Y?=
 =?us-ascii?Q?+da4nz7v43yoPr43LvKstMqb/ES1YZJ81NGwlDJtW9QkBPtrK4ZHnDW8g7aE?=
 =?us-ascii?Q?/0scS+fkg4LogwWwTAswdFfgFmRNBA9mq3o47tgaLJ0Zn2IEcmuM/axcNoD5?=
 =?us-ascii?Q?7Q9tuhjNDh9M4Jm8Q0xzLftCy1eRsn8kTfA0Ud8Si+zXj+b6wIrNlyEjCFG2?=
 =?us-ascii?Q?u8WppkZ8+97JmDHPZ7bGZOvpbYGU9tgpxRnwgPLSGRyEe9feI6EpYHLPSa/h?=
 =?us-ascii?Q?LJzLPl8sgJ0bzpYxftY0p9I5z6cLHAfQEx012owMoc7drxLZSLrjJbWb++WU?=
 =?us-ascii?Q?nhSFWuKtzXivqjNJ/1taifFcv4kkIzdTXjVoxZhuQkX7Lnq4r7QMNEcouEDq?=
 =?us-ascii?Q?uIfBOmhea7zbUAFCxvt/EK2ITlxL3NEytZGQG01taJBWaRVxAtBIA0AOysfn?=
 =?us-ascii?Q?S27FUcdPaSs0EQlJKX0UHsuVC47ezvnlV+De6jy3lmv88tFTIkr0uPDy2E6D?=
 =?us-ascii?Q?pvtnvgTLW0QHp6LihOgnDNbpgpMhvfZTsGVKab83fk4kwNuI5PjBS6Xgd9D2?=
 =?us-ascii?Q?IOHnCvgoUPtH3/UKwLa37JpyWgV431471eQxI7jbLZ27JrqUEe/r+rmiYjDy?=
 =?us-ascii?Q?eXN9Wb5k/8bqRZV6MJ4pSRODM+jl5z2+PwS7j/47vihRDpwS5HQy31BtAqvF?=
 =?us-ascii?Q?upWtzVMxBpEAQIVLml0j7QDJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc44691-c553-49c2-4013-08d94500d24b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 06:46:48.1224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQZJTJGrngs3nekW5jzs5hr+sZJXZ8OJyhotwsyXXLKKWk5TH77+Y2zOU2v0IcMs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7671
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/12 =E4=B8=8B=E5=8D=882:40, Sidong Yang wrote:
[...]
>>> +	sk->max_offset =3D UINT64_MAX;
>>> +	sk->min_transid =3D 0;
>>> +	sk->max_transid =3D UINT64_MAX;
>>> +	sk->min_type =3D sk->max_type =3D BTRFS_EXTENT_DATA_KEY;
>>> +	sk->nr_items =3D 4096;
>>
>> You may want to do the tree search ioctl in a loop, as it's pretty commo=
n
>> for super large or heavily fragmented inode to have way more items than =
one
>> ioctl can return.
>=20
> I don't think much about this. I wonder if it's proper way to search
> tree. is there any better way than this code?

Here is one example:

https://github.com/kilobyte/compsize/blob/master/compsize.c#L179

It goes @again label to restart from last offset + 1.

Thanks,
Qu

