Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92923A3D7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 09:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhFKHsO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 03:48:14 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:28587 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhFKHsJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 03:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1623397571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HY3joFsFwZpc2q6B4pYQwy2jUSJT4AEYmZ1lFD/0Alk=;
        b=H+Qe3HImVbrMB31qc/A4e1Ewb1L1Cz684ECTxGigBCnnm6e2tP8aoTCdllrGLGD1hP1Dyj
        uD32ln/LWfDIEi16Dlc1NW7eRFvrOKzygDvHnyNF01U1rtR9M4TYejofaTuw2jlFGTaYjS
        jzPRHFDxoKmbg4cy5q5NRcPw0kWcpFg=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-mMM8DU1gOR6rDNiHfSO4Ag-1; Fri, 11 Jun 2021 09:46:10 +0200
X-MC-Unique: mMM8DU1gOR6rDNiHfSO4Ag-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDoYBcXT1Pko85G3NY+/+ZdLeEzNI5bjbR0MGHXXLhJjqYKPT1DVb54HHoyete6Ev7wzjIZJkaq7ZDowoW1sBQ3eaaEGm8sMbjON4r+IXBA21XcmmIKGq1X6iGI53hTrbh3tk58TUi4ChFXrY4+NpD3yRbXFMyIfaPb8gnY1G+Nk6K0b0wyMCOXJe8ajAIQmrY3ifnq3OZNrxGcoLkvKBmiQ4zF3Fm3eXhqgQgxfFUQpiMSBrUk4+/rhgRWpeI619pHxzhsVXp+zD1S9V0w6oOzSWMGa/1dfYrL4nCJnYIuW5skvTzH5sU85XEN1HRMDkbepCrbC8unDy25r1dXGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUBY8n5br/Q3MMnqsvuDxqAycL66dy3cS4e+5YKODRc=;
 b=Myz5SIlsz+IhmgM1DYSkz/exXUbZx4TJeDox0cLRDJomMoaQIIl926O7IB+2TPd+ScM4wZYDi48nZxhthirJ70MVzTNbp49zXtdwk9SncjDL35nQjwxY/CJodrxYJ5hKEgTv6TXpDIkXBDwra6HFT5UpjlNwasXuTmQFIC9TufcfP0jiA7SqVLm7j49AFvic74r5IMMfIAK0RN8D4TaI2pKbiYUa5Edppz5kjYARCCplRZi6O85rkwL2MfyMQLu79mtBWrer44emafzGFtaqJH2DF+RIz55vWKgR1nnChLJNH5jvP23wQCWYROd3UfSwWC+SwQKKF+AX7x1Ogec8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0401MB2449.eurprd04.prod.outlook.com (2603:10a6:203:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 07:46:09 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%7]) with mapi id 15.20.4195.032; Fri, 11 Jun 2021
 07:46:09 +0000
Subject: Re: [PATCH 4/9] btrfs: hunt down the BUG_ON()s inside
 btrfs_submit_compressed_write()
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210611013114.57264-1-wqu@suse.com>
 <20210611013114.57264-5-wqu@suse.com>
 <PH0PR04MB74168CCA9DF58BAA47A965D49B349@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <1ff0719b-db66-9485-6b5b-590c3795a3dd@suse.com>
Date:   Fri, 11 Jun 2021 15:46:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <PH0PR04MB74168CCA9DF58BAA47A965D49B349@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::23) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:c0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Fri, 11 Jun 2021 07:46:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e610b618-bbbb-4d18-f81c-08d92cacfa45
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0401MB2449BF97FB7A52931D3B3298D6349@AM5PR0401MB2449.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtaFZEQ6KnSGqGUhRNENOrkIWAm7PXcsHyzMdeLIEAU2BoCHpu6cE8wJZP0o9a9X8l2DPapgq0N6NMYKzUqoVHccm4kEhbRiGdBuxw9GxV4Lrlzq3UQM8qvKKxHSujNr7OuJy1Amc9DYv5m3qdIfMjn1f30RITEfCuHenSa0gn0YaFzdWxbJuwrQtiMcXH7BTP0y76RcO6vyoEu/PBEYCXoDDcvpUiBNjqa0HeHI6d7tMPL6EirE7dbncO8qCDP6ODGWfmNI/1MJavNIsIYVqhLeMRIUfCNa1RilAOZjeW7SeKO/IFzf2raus9gA+GbgkVtAeBG0DoILkRb+HP7GMuXYf0Rkj5Gjg8Wp9IdjJ1XgjG4kMJVToTlFo0eXZr5x0UkOmqbl+RBFeiPmclgNOyoAaXuIBxK887LXQ11qyrmnzIFyOA2YLQIuCnOpVQ/jjU/n7qsuDICSQGVM8tUwG/aObe3kAGFFv8eJh0NMEC4DomEUTBtZ2F8pGqeJ9DISPrbDfnnKxpHNjAoQYci+RtAbDHdM7ahccFvZX26PAuuzfasVQpdrrr7uOx+8J2MzjuRtB7MmjTrt8ULDISRnl0OA/A0cf3OOr/B8F9++6KW1aNhCL5tWgGCYGo/Fl3xKXkWxaNy6nA7KrzGriD9Te1oF2ykijQsnCrjI3AtpPXLrP+sxpKrHqg49gZU/VWnYd1qe8r27UlP3Aw5kYGCfyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39860400002)(16576012)(6706004)(38100700002)(83380400001)(6666004)(8676002)(8936002)(478600001)(110136005)(31686004)(4744005)(36756003)(53546011)(66946007)(66556008)(66476007)(86362001)(2616005)(2906002)(31696002)(16526019)(956004)(6486002)(316002)(5660300002)(186003)(26005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Y2Lq0TSlWnajmNYgNDRgsZXuO63ksUMnsCVnq6ugGXyAOZMnlNp98zpZjsG?=
 =?us-ascii?Q?2zUt/eGfqI3kp4jsZ67F+aBGR//FZj8uRnYt8//aKFQ7EMZq+UedR4nnxTOO?=
 =?us-ascii?Q?KRzcFBOrNHpYiQ+7iCR6ERZDsjJu1xP9AuxLq55pzpCFwLMACu2/NuiFclvY?=
 =?us-ascii?Q?2tOVnS0/KQjeITQpd0mbJc+FjVYppc5zbO/N34AVMk0SirAhcn+5Ku3uZcU5?=
 =?us-ascii?Q?uDNjZazI1NPz8YKJiw1CL1sKB33v+PC/VwZGljvWTFCJgF7cQREDL94EyjwY?=
 =?us-ascii?Q?Py/xjVXlcqRThxlxP2TDDbVzc7qni9MShmTnYI948IkMFcudix8LKhUUUKCH?=
 =?us-ascii?Q?w/na4zw/n7mKShGAk45fYwPx4Bk0WJO54ONVPpRxGPB1mkt8pb/I5Ullstxx?=
 =?us-ascii?Q?i0G18Dfcl4ZLNfLCfSWaD78nMqV64IQk9JzDD/GzsWIMVuAWXqX3OUmao/Dc?=
 =?us-ascii?Q?JTyjULqzyE8Hlzbl6+C+IMDTXdF3YJPTY27lkOq5vACDcPumuCnxOXRHqXPI?=
 =?us-ascii?Q?GFMQzXPMG3TbG33W+FOwilnIkgwn+UZbRHrhu1ciMUzOyOpICKqnaZzVG69S?=
 =?us-ascii?Q?ozVltOtORlJ+X64wcibQdUM3mjgSRfBACuZyeFDzvRE5KAyisblJPDpiEjea?=
 =?us-ascii?Q?EZh3ElXk9AeInttN8xqGbyAe3uqCU1oHx90cpVLh/aThyxd9YSgWNywrSprm?=
 =?us-ascii?Q?DumSNSMoOg9kwwLL90x2yXh98KtmFadHh6nDt9fm8vAaWdzl1EUjLw6rL9RO?=
 =?us-ascii?Q?yAbuNI1PgJgOMPICSSv7Lsh+jFhs6G6ygyDHkoGU93ynr3W+0Zpu09F6mAkk?=
 =?us-ascii?Q?aLLfN+phJSKMvcs1RyeSDEM4jGS9+mSFKdSkY+DwBZNVjSC1fEEm22CyG6EO?=
 =?us-ascii?Q?Zzl8lMk1kgd4HpdCSdLGcoy9nyNKaePlG2Mz6Fyav8gES4pnPD0/nt5vR6Xb?=
 =?us-ascii?Q?5UXwVnWn14PzLQ0x8q8eLkdxorAZBIB7PA16OqhqdJzJGHBg38Wvt49DUlD2?=
 =?us-ascii?Q?+i8ZqKfirwHGDg91uMyVGzirsnXvycy9CtEAq8SMI9/cxUgfwZQii4WPdeTV?=
 =?us-ascii?Q?XeF3kt38T1j4A9pnof9OGb7PYVd2Opfgd4lGmj0wUtuNPRt/usPkG9ikQ0QR?=
 =?us-ascii?Q?6lcgZdZsGRS9aYTc4ncAn8lpdy2UxRGBhLQxb4ulMsYGTCoeg2QWau+TSMXp?=
 =?us-ascii?Q?LCnZ1p2dK7gS04pJDCDx9rXCPDq9eJWz9zPLkA3qIR+RT29dY6AjtVEe4B9O?=
 =?us-ascii?Q?YbjvwhRxvuzqepgVGm+Ijtah0+L+ydycU0eTw68jKvild07tkk7yNA3e++EA?=
 =?us-ascii?Q?qSRhA0LWTQWpf5C7bmEg3FM1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e610b618-bbbb-4d18-f81c-08d92cacfa45
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 07:46:09.7638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGAqW3TODulzI1E8a1UfwXFVkCHAuK5z2yT65c0IZ3DrpiwdaLZ1J6EJl7rT6SPh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2449
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/11 =E4=B8=8B=E5=8D=883:36, Johannes Thumshirn wrote:
> On 11/06/2021 03:32, Qu Wenruo wrote:
>> Just like btrfs_submit_compressed_read(), there are quite some BUG_ON()s
>> inside btrfs_submit_compressed_write() for the bio submission path.
>>
>> Fix them using the same method:
>>
>> - For last bio, just endio the bio
>>    As in that case, one of the endio function of all these submitted bio
>>    will be able to free the comprssed_bio
>>
>> - For half-submitted bio, wait and finish the compressed_bio manually
>>    In this case, as long as all other bio finishes, we're the only one
>>    referring the compressed_bio, and can manually finish it.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
> And that one doesn't apply cleanly as well, which base did you work on?
>=20
An old misc-next branch, with some subpage patches, which shouldn't=20
change them.

I'll update the branch to solve the conflicts.

Thanks,
Qu

