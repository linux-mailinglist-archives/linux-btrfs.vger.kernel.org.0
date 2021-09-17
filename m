Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1005C40F6B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 13:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbhIQL3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 07:29:07 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:29327 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241761AbhIQL3F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 07:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631878061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z4Mglc2X44hubvnQbAyyzx6YiachkSudWWKfbbXPV78=;
        b=h3w9EDZEg+EQQ9fTJagUmr05NZILslgB/KpecnjNvavrkXr8mmOnFt06Fs8a8MF1FSeYYi
        gkCoMPlJHQtglyP+MJe8wukBgPZMvu48pTfW2HGd7ayH+vGL39mM3uc98lka4IPmPSD8yZ
        rrdzXmoMJeIqq8CadVnzNqpKbfQSGrg=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-Z6nA591qO6Coh5gHdPfXAA-1; Fri, 17 Sep 2021 13:27:40 +0200
X-MC-Unique: Z6nA591qO6Coh5gHdPfXAA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcWG+g4T4yCgZp7znLhrdAEINrcWPckPsx3GpmeKhs0+S/Fd+X3MuqW2PNGl859oD6PDfQ5JjjI2Hl0A61B7roiYS9yDlxTnJvOOGsf0pk2G6HLz+ZJh5eTUCAkMWyaPKP5qgnTVKAbmvx8J+BMzMrLb9c8clEZMpUxMvj2QL8Nj4TW3V3MX8CpUHe3SDXDBGZ9Mv/cIrobBSCi9m+bX+tPjo1to4aCaLq45oJhKQfSNviFSfeaL/v6jUGaZXvQ6sgYogyNJ2lhmA9G1suYUklht0QlHv9uowY8iV9Ibe5APECix2iL/bI0uTRUIXUXATfQJo06DBtnuiHzg8VJEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UP70Z5cxMJyFWeE30eyiF3ZqlFSQzDX7DXDUGrHgEdE=;
 b=P4sUzby5Nu6HEBJ4sixOy+D6zhEVjJWfYLut1NsNa7HoIg8tHTLP8uRjyVtbePPNCeUhsXN+2s7tnxLoruN2epVYZMr3BoD1vYF9cFqlXYvHqk+Rwow8dV2PRXx1PGHt7UkwZFPmjE/Ajr3TDoD2s10bi0qICWmcEXixVYSAvzZQRzQseoBgU7plqysUnk4GkJGr5/mG1RrI5FW5HhKfmbbZ6UafXQNzTkVGjd0eRuam66Ilk4BsINNbyy8TYFsMXWC6cAVMJIU4ngyX+2sXqjHM9Wk2FRFb3mHyQrDsw1RgF/zQbS7evANRG45C/6F+JlO+u+qMx+PG9b9jyz1EoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Fri, 17 Sep
 2021 11:27:39 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 11:27:39 +0000
Message-ID: <5767f47f-fd6d-1c50-e6b4-90c8bd0d8fdd@suse.com>
Date:   Fri, 17 Sep 2021 19:27:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 1/3] btrfs: rename btrfs_bio to btrfs_io_context
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-2-wqu@suse.com> <20210917111923.GN9286@twin.jikos.cz>
 <c0d3f033-5b53-4026-d38d-e7e9284c1f80@gmx.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <c0d3f033-5b53-4026-d38d-e7e9284c1f80@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::34) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0059.namprd05.prod.outlook.com (2603:10b6:a03:33f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Fri, 17 Sep 2021 11:27:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d43855e-d2df-4111-9fed-08d979ce2835
X-MS-TrafficTypeDiagnostic: AS8PR04MB8371:
X-Microsoft-Antispam-PRVS: <AS8PR04MB83716E4F62CF4555A1C8F08AD6DD9@AS8PR04MB8371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XvNDyG1q1Vf2izDhh/j3380vt13AILNpKSeoEZEa/WY95m6aTs58x1ebDRFj2zFDOCsH6Sb04Ey68ab5HQVG6KXd9XtKXAF4bftVLl+ESeHqJh03Xt+3NbK9YYqGc+S5oHvL2IasI+kmkxWXBFt6/v6/AAZm5ztRwZvjnsZJZm4YFIXgUfPPRQfiZjVIcLMbdHKSDbNF3496LHozLhkAYUkgAMJJVYlurw/GPbpz9/aGAkoOiflLcU3Q7d0CpddMVgguNZJ2lL7c2nIlA4351osCFCMxFLTqco5zaYaP7LHuzBkhHbhwOpGdyexFsc90ucVza737EjkCdtvKMR/o9BRWwrCTM3aM1E6LdXLerb1DsF5mre1GlfDeLaxF+TSf1KYTuXbF5WlMAdkI7eiunZ3GlthFG8SSyKGKnYnNzejyzUAXJud6AEpJHahkDQR2C2iriTdgXRg+3XvPiCrvnkj2r2eA/vJd1q8p9O4ic/gEzKIOrjGRSIBVFGcBwLi+cud6IuYCXpBNFmJjjWOebpX8OF2zn9kzDJ2EEVI3Jn5tnxf7+dYLQjlAPL+E7Ex9icbLQWJNu6D9tgQe+Gd/u3eAsCSVaQPNmBWQkkhBigfEyhelZ9K5ZXLKfVeT90O3Sg5i8LVGkbUjMNbZgSwtD1rXwLT2AhCXCd7A8Fe+Cg9FYK7Pqvh/qGrKseLw0OH66jg3N7uoqmYL1X32hqe7OmeCR/RCmOEVyzlVbXA3Sn9KgMB9oSqrfnHwVhrsDMnPAdhAqgBLWZjP8iDmlF3PpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39860400002)(66556008)(6666004)(66946007)(53546011)(186003)(26005)(316002)(31696002)(6486002)(5660300002)(66476007)(36756003)(38100700002)(31686004)(956004)(2616005)(6706004)(4744005)(8676002)(8936002)(478600001)(2906002)(16576012)(86362001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NyQZG7F3cvRZZeVaLyVMLtirwiFGepT7iWM6zDCo5tATl7C04reannD7bvWA?=
 =?us-ascii?Q?aXHaLVQ1gfsKLO8f7Twv+MDmzMNNMFEvWyoPPyr6fTxETExR+/CcASdVjAuO?=
 =?us-ascii?Q?cvzosBsL8nbQEv2s2qVSqCWMrOjfwcEt67tDOqiLQFPINLx2QJ3rPmwWt1UP?=
 =?us-ascii?Q?nkoHg9P1eYMLkwgz4y8eKr6CdzxYOjDC/Vc2Vl4H6L/wRmY9IAGY1LvIp7sU?=
 =?us-ascii?Q?sr9pkOQ5UJMGrOIeLH4F1AQPEYiZwsose6Bi8wdGWfG0zUD3Y4ikw0o5RLso?=
 =?us-ascii?Q?LRlgybHBehEb8FkTIzY1AsQ7gLHOJxxsQuakxndbb408WO356GMHlRgGBI7R?=
 =?us-ascii?Q?zR0KBbfyC5l+5ppuY7JiTTE7dw0Duj5o9DBwXw9FcHe/ZVS4mHu3EKCpOs/R?=
 =?us-ascii?Q?jNCudXx0BCePcijzY1cAy0212paXEqaHtLOcwK75Z8UC55rk+rQ+1XO5JTMo?=
 =?us-ascii?Q?i+qPe/U54lqoQUl0K+5FjqVxkzKAbZEEbT51dYNJnR4GrUjV6W16smE6rTaS?=
 =?us-ascii?Q?ddGLguL0t0kunig/TSXG4tYdDc17WHtcWWPt1pDLM9yzqC10OWM5f0IA6Iji?=
 =?us-ascii?Q?VruYlzP/p/3bTxiiS+wh3TzKL9XUSYbwYWA4j2RsKQ40/8VkJhKKmUrNnf7S?=
 =?us-ascii?Q?8wlMKZtvHMB/LcsOP2OoCLl5BmhM+Cw7gIa6JZ+9NDNTKdWUZElpyU2LK9iR?=
 =?us-ascii?Q?bWROdEjlwyisMOT9H0hNwyxIDCX8FODbfRTUSY+XNdBjlQ9HfGGBLR0eMbGo?=
 =?us-ascii?Q?S5axWPFfsMyGZIPrF5IwRVYaiINdANjC4PZYpOXJ14kgCSFhh75z+y1yg/7/?=
 =?us-ascii?Q?yGnvJGHxiMbQB0qLDPreNLnkD3wW6aEjd5qgk0J108nlzMj7dSCHYn9twhBb?=
 =?us-ascii?Q?CM7ai1rERUl822zc1hXaDDmhPRlcdI6/ZyZUWWmh/nq4wAWFP3xoeVoIEbo6?=
 =?us-ascii?Q?yzAGk8/pFT8YYb8OWUOQV1dSudvt0BKXtG6wBdjMUd/G9r6j8C5xnlIewhWO?=
 =?us-ascii?Q?D4lOWVXShUXFqUzF5RoCdgvkLiGEJ0M+OZ6RSykRFAjEqB0IKKqYc1LXGtBx?=
 =?us-ascii?Q?SXw3vMlNof+ACkJP63ErRB+NrSwIb1/fLTRam+Y4v12e9aI8KxO1kXCjPHDE?=
 =?us-ascii?Q?Iybots2np0au+OVG/aDgfELI3KTbDctVO6QoDl21No/nWFA7CL37KOKYKZGy?=
 =?us-ascii?Q?+0PPmTdJN24dH/mDgwv7uQ3W7zUeEnwyvkENBiUnC/5hF3nFMx+mZuGDMlsZ?=
 =?us-ascii?Q?pdmMLhFjDgfoW7i/6kE9E101eHQtRzYgE2cnNBeonJrbvWoZMZk6eaXuMjeW?=
 =?us-ascii?Q?RIMzJHopdbTrXIZ6vSGmhBVm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d43855e-d2df-4111-9fed-08d979ce2835
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 11:27:39.6782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACcMDWD89Cn+fcL2kpRwROh3/lXpWvWCdM/YOwvZB7HUnEjRJc6jSR64GeQvcq3X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/17 19:24, Qu Wenruo wrote:
>=20
>=20
> On 2021/9/17 19:19, David Sterba wrote:
>> On Wed, Sep 15, 2021 at 03:17:16PM +0800, Qu Wenruo wrote:
>>> The structure btrfs_bio is used by two different sites:
>>>
>>> - bio->bi_private for mirror based profiles
>>> =C2=A0=C2=A0 For those profiles (SINGLE/DUP/RAID1*/RAID10), this struct=
ures=20
>>> records
>>
>> Why is SINGLE here?
>>
> For single we use the same routine as RAID1/DUP/etc, it's
> submit_stripe_bio() doing the remapping.
>=20
> Thus there is really only two types, non-RAID56 and RAID56.

And there is no really "SINGLE" profile in btrfs.

As even for SINGLE profile, we may need to submit two bios to two=20
different devices (one is the current device, the other is the=20
dev-replace target).

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20

