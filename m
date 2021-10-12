Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118C142B0A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 01:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhJLX4E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 19:56:04 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:33712 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232243AbhJLX4D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 19:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634082840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0KYkFL5NVpPC6v1t+L3w8pQQZ5CqTsPwSzLwqVtCcX0=;
        b=WrxkVu0cspt5UJO7ZXuB9F/WTu30AzhiJuyq4ydUtEVrqLUoChecFZ7eMJ7zxPXDQoX6L3
        JBwvy1K+VVCDOP2i0/XJfUfJX6yk1BSNHg9Wz/M5BCh6sOIgy1UGdFaNNZHgkXdHcg4JuY
        UDZN1soNhOuinpQDl3LUoMAfeKveZWQ=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-4-ZB2RIeYTO02GRTJabyR54A-1;
 Wed, 13 Oct 2021 01:53:59 +0200
X-MC-Unique: ZB2RIeYTO02GRTJabyR54A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4IsNVf/l3CIuJ5fyZYWOcMLfN10XagAqTfajjCfqrFVSXQ6MaD554nsz6c5uULsBeYO28G8H3S+lQVSuVU46NGFQwZPPAC2FWSxKDV9qfqsHeSi/KZKZRsSIqpUR796Nei2yg6BcBE+ABqOx4KF27fZR4Cxze/ARWmSTkcTjAE7pCTQaf9aKJpxyGmC49s5Q5xFLxOrrnhW8OVsgyYHbmCyzZHvRNQyeEHpUuD2i19RMHxErG2Nzso1nRFNM3b7bWnSsvqtDks3qMR0B9GKMw00bxabgTWBahHR4dwaO41Xs6OPV5bZUeBwPXKGd9u5LYpMpLmo1JhKmcsdCgQxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CPTSE/hwo42Hq0ybATU64Izh5mkwUxsY5PLlvdOIkE=;
 b=bUhwWc7vFun6tEuBNzWlc36lVH34UMoJRoMa1wHmJdWG1ytqeafTachrWygykaHIAH2vW0snnI55LJiaAnkh5g83bzQ+VzEakskBU4rd/SsL1RHo6EzinPdQZK9Dunc7lRfVn1n85S7y9JJjQbW+XpOQUSnZ4VieaERipP/DCwmrsMnqxPCoOy5FAwjnEqLU+1rsssE5o4VeM8p2vuSH5ChAz8eWiH4lyCdE3CT6v7oMh02ljH4BRldlAzxdZewpoiKSM9Sh6roBgoR+tjCoi7T9BwCjgnIAcgKGxFoierndlOJOnAPK+k1/ATNERZccdlEYttuj2kp76aDZ4cw69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8310.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 23:53:56 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%5]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 23:53:56 +0000
Message-ID: <7aad61f4-1b47-eef7-82c3-52ed3ff5dc48@suse.com>
Date:   Wed, 13 Oct 2021 07:53:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] btrfs-progs: print-tree: fix chunk/block group flags
 output
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20211012021719.18496-1-wqu@suse.com>
 <b331b0a3-8119-d66e-c49e-742262ad4a9f@suse.com>
 <504c9584-e760-54a4-7ae4-1c4f26ec5323@suse.com>
 <32c39029-8434-e3f9-0d72-740fe6f44bff@gmx.com>
 <a643cdea-5130-c44e-ce4f-dc8fa23e7481@suse.com>
 <0fbd2076-2b6c-4531-01ea-84db37abf621@gmx.com>
 <1dea2507-5dfb-75ca-7bcb-f1114f5929b6@suse.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <1dea2507-5dfb-75ca-7bcb-f1114f5929b6@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0204.namprd05.prod.outlook.com
 (2603:10b6:a03:330::29) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0204.namprd05.prod.outlook.com (2603:10b6:a03:330::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.5 via Frontend Transport; Tue, 12 Oct 2021 23:53:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d563a714-53e3-43ae-7fed-08d98ddb8da8
X-MS-TrafficTypeDiagnostic: AS8PR04MB8310:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB831071297380C1BC057711D9D6B69@AS8PR04MB8310.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oeGRVM3zosoDyC+dvyhri2YwmV2gCk6uSpSXoDkjhyqlEBdMUCLYIZA6+bBkCKSfwm7N68PYWxeMsvibJCQk8CZtJfh1Y2yl77g8fCVtADPcPRzTkYPVwlyGiUxiGdwFvZOCI2bXrbwr72M9aHLVYdNNh/msKebvwN0lCuerp1HODCMXHwtztvrSwov/+DG5fTdY/6meCXDVsFqZGxNoRH2It+RTsjCeMcRpD8JDhXw8uvs99BOKgHJw1lE4n2ZPVOzWvTVBQH7BILjjAZ4p9ikzBxGZOkl0pnc6YVYrtZFgkT2tSd/Te2ZmPR8PVGmxllUHmKEFOuppp6V7swAyPnUEJxeMz2/G9Y60ZbncRANW8uZfySt0afo/c6S59YQG+iA/p4CeUYF2aiYmiRUN4H+h3fdw7bDqYsxJrh7VAH2NYncc/Bseb+aroapbkN0kSG9c2xSwgdhi0lIIff2oGm9kdvs24fAxLv/YcixxojwqphmkyLwv88MrOcXxpkMZomw+YXL3labmNSTc9onY7IYp5jG0Tdy8sPpehrz0aFb9qKTzveT9C72NZ8IMfYnGO+gE4Y1qfVY1WXubDa0ijTGM79q/VxmH0kf1isJrYZy2B7W4L/INRldwdaWVclrKDv+Q2+a1lwBFC80HrH51x9aG+RPPl92uQ8XZRc4yzCbQVvOfp/NUF/VHAOWdX5fiZNuGT5t2buHgc9RbTAD5lcfjwNY8nG7fD+dIieWaBf/01pdvQMm+ove1PxyoYzxN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(31696002)(956004)(86362001)(26005)(6666004)(110136005)(5660300002)(16576012)(6706004)(316002)(186003)(38100700002)(2906002)(31686004)(66946007)(508600001)(66556008)(53546011)(66476007)(8676002)(6486002)(2616005)(8936002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LGOig5cu2LleZwMDIniAL5WchonJB8l6duNZJJ8ZzYRwIColJKQGsEwgxe7E?=
 =?us-ascii?Q?zfG8YB7n4qi4xoucD1PwP2NJJoU6IKQGwyk3T5QxahY707Hh3KPsIPAjoi12?=
 =?us-ascii?Q?MGDuW4TQ60BvXM+QOSN0WAoizxIV7VL7UTx2/FC8wtmCUZKlHfJMCugCbTgG?=
 =?us-ascii?Q?QZ3wT0lHt3wy5mLVqWjIOIwR+gcdXniH24oekWAQADC//kO9M0fpdq7F3Tq7?=
 =?us-ascii?Q?8zaPrsCeD/Tm0vS8VL9xG3le1mz5wJauWsvWDuiKBoa4/WsmGlJh+cpwyKHp?=
 =?us-ascii?Q?eaoEJn0ESLLg90Z181M4Q+DvFY2OUKU7Ua/6MNmhmdvX0GYhaHBIvwsegOhp?=
 =?us-ascii?Q?XLl45akBDFQsi5vCkiSVxrSQTDYDWop37DemYWb4NTCt5uN/lQkB3fbDlj1e?=
 =?us-ascii?Q?/k4rxTXmHA0VEyirTfm80kN5DEjlmoDkWD0H5sWvYMilLwgbsDUfpCB2je+z?=
 =?us-ascii?Q?dgE8OaWiWGHgAV3SmgVH7g+nBdPvmfe8IrGZeU5yjyAs2/am3dtt+qMP0iFL?=
 =?us-ascii?Q?inWO2PTI9WiNniXWHmGSF2Y187l5Qa/e+VG4AjOglFoD9nuzupTMNInkc+Si?=
 =?us-ascii?Q?KFSrsL1e5bUC/Wf5xdfPDxt+NwmTB2rj8ll13PvLhHaKv/sxlZ3gXY37wajV?=
 =?us-ascii?Q?ZGrcNvMeMtH9X9xuDyTxVLpG6leRB/Yi0gROKfvs8BPIVRskBYES5IYhFs/i?=
 =?us-ascii?Q?3odL0qwj2NujR2EqyKElrHEExnW72Dde2g6wD3TjaGX8nJHE6RvJ+KufhSWo?=
 =?us-ascii?Q?1zmd5oOiyMLwORQC/dz6tabV4xG2r+vTDEKvh5aBP6cUh3LXKjKahHnESKQ7?=
 =?us-ascii?Q?wjCyPUczhMaqXfZv1zqLMhP9o/srA1v5amemlNOjEiBhqo2zPxB0xululOYo?=
 =?us-ascii?Q?JRtFsSZBVBIkMVEEJ2MlRImVOpi3ogRquMAjuLYVMFd9x1FA7J8EWwNrFi8V?=
 =?us-ascii?Q?3pDFFAsBz6udVxeOndPhnm9Xadw4e/gFbOtTx7CSres3fjj05yi703IVytTI?=
 =?us-ascii?Q?NTIo3CV9Y8NYZIRoxBYze8SBuR1oEwEfsa9bgBfckIizH7tsYKSegdBA0mI4?=
 =?us-ascii?Q?ZKW12PbMSs7KqddS51MPcW9C/ormZbkQrihOiVGafIwT/LjtOlGjt75YjvNW?=
 =?us-ascii?Q?oPASHoa/ofBYqFN945JOcqZbZeabjPtzwI8TktzXvq5br1p1RuaBDLT2le0F?=
 =?us-ascii?Q?oHhxIYcWAcMOWl7xs278kbHCC1O0AntC0hFgOep4qe+ZLlBj9qxgTG2lpcZt?=
 =?us-ascii?Q?SC0Auf4tLQO7CiVrtTbPMeB966xI0fa/UABAgyRqXDBlUMZ4uTTeNVtH0Z/J?=
 =?us-ascii?Q?7/Foivk0B8crgc5ShTI4P+16?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d563a714-53e3-43ae-7fed-08d98ddb8da8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 23:53:56.6965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5EHhnhllX6knSaxWRk6MwcqpI0PHoZffVaZiJUXJUrnxfPmMTRId9+JyVC6/2fD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8310
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/12 21:59, Nikolay Borisov wrote:
>=20
>=20
> On 12.10.21 =D0=B3. 15:24, Qu Wenruo wrote:
>>
>>
>> On 2021/10/12 19:56, Nikolay Borisov wrote:
>>>
>>>
>>> On 12.10.21 =D0=B3. 14:42, Qu Wenruo wrote:
>>>>
>=20
> <snip>
>=20
>>
>> There is a special handling for SINGLE:
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * Special handing for SINGLE profile, we don't output
>> "SINGLE"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * for SINGLE profile, since there is no such bit for =
it.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * Thus here we only fill @profile if it's not single.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (strncmp(name, "single", strlen("single")) !=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strncpy(pro=
file, name, BG_FLAG_STRING_LEN);
>>
>> See, if we hit SINGLE profile, we won't populate @profile array.
>=20
> Fair enough, I had misread the !=3D 0 check ... However, I'm wondering,
> since this is only used during output, why don't we, for the sake of
> consistency, output SINGLE, despite not having an exclusive bit for it?
> The point of the human readable output is to be useful for users, so
> instead of me having to know an implementation detail that SINGLE is not
> represented by any bit, it will be much more useful if I see that
> something is single profile, no ?

On the other hand, this breaks the consistency of flags output.

We only output flags we have on-disk.

Showing another flag which doesn't have on-disk bit can also be=20
confusing, and break the existing output format.

Thanks,
Qu
>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>> <snip>
>>>
>>
>=20

