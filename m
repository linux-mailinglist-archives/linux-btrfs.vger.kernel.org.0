Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCB03AC3E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 08:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhFRGd3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 02:33:29 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:45743 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231350AbhFRGd2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 02:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1623997875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=16NeATO+rAWtDGVzD3paA8MGh0HDW7gttOUSTi4Onw4=;
        b=YoAL+r/aqNZL2awyzaZXjKipPzVvZWwV/jIUvJa3e1HotW+20erDmDFgH+wfWeGvQQoPAE
        YiYo6kxrEO/tN8SraqLR6+5vBECKnB18YFnxj0Z/w2iFm385e6UBzm4ZeKGSvIfbS/PXaL
        Cv5JSOZYffHC3APuJuEV8nvaOPOE0iA=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-8-v70B4lrkMMuCrSt6kmdZAw-1; Fri, 18 Jun 2021 08:31:14 +0200
X-MC-Unique: v70B4lrkMMuCrSt6kmdZAw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ji3PVFDpAAvoqs+alXEtzMIp0df1hx9XJqyU4yo3ZqFh7JnIptEPOiyaJf16EZeymiRkuNAFUT7N82abs7g1UAgRhuMtKprNCrXAmLeifExFCmAUWQ3tGeirRch3xewWHAnxwJM4PQ62CjgD8Df2HwQ68leF76BAkt5rUPN29gNFAQV1MXur4yBg5Cg/tQibwtC12OlZ5BVWzAP0J/pS1ZmeHWsiqIbSkKXvOzOusQnsKlExpn05ayMbd++MiOG4BGm7uQ14NQTZHVjArysWALygTV8woLt03RDUjnFizLE3CSRexVjOaSzilMZU7M4loblBeTc2fzS3TCUJEeCYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veDGfnDZrLXR+ieBLavnw0XJbHrGMGBGbkaISpEo7lg=;
 b=Vxec6/FgYcO04aE3xYSRBMzoOvW7d9BHzBs2n+bBdJIJBwu0X9l1bD337oOKEi7OL3WCJJLV7fwBKy9/RvsQznhBv96fbJP7kzLSOuksnTAsttwrCtEuXyMM/8iSGTiygISkw7i0JMvEdz86fAzFNvxfhExMWFgNR7FpeQcjDAgUD1k22nKtERDFjHMk0U/xkizZh7SShPj79ykHrEM+sLoxtOZjwV3AIGWG6jn6x9Tj2bDKPafw9I+wcyeex1k8xRGFVhDxoPKabY9raARJZ63IEPm40+L1Cf1MMoHQUzxNe9VNwsBnsaMtKS/FtaKm9LnXe8Q3taQzFCflyW4RWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8309.eurprd04.prod.outlook.com (2603:10a6:20b:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Fri, 18 Jun
 2021 06:31:13 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10%8]) with mapi id 15.20.4219.025; Fri, 18 Jun 2021
 06:31:13 +0000
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Please don't waste maintainers' time on your KPI grabbing patches
 (AKA, don't be a KPI jerk)
Message-ID: <e78add0a-8211-86c3-7032-6d851c30f614@suse.com>
Date:   Fri, 18 Jun 2021 14:31:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::30) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR06CA0017.namprd06.prod.outlook.com (2603:10b6:a03:d4::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Fri, 18 Jun 2021 06:31:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8bb6526-3679-4876-ca9d-08d93222ab0c
X-MS-TrafficTypeDiagnostic: AS8PR04MB8309:
X-Microsoft-Antispam-PRVS: <AS8PR04MB830983F9710DE2B7FA2947F3D60D9@AS8PR04MB8309.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8VJ0Cyr5Iti8a6IRd5x7wf4s4jD0lR/eJVPUKh/+8nwjMsL2LkxO7tLUtggtZsVW5Mol18fISUpbB+7fRBzVcBOd3T137z0CWVlp8rXRpgmzS0eUDPZal07mHARkJSsSBrXcMeh4euURj5gt2Kywn3ToZovAd2FkxkKiYwEU8v9zZ6sKHw+AuRSwhDF/kGBGgrNkg3+vZAlhV6vtPRQQUtzIMKAbpSYKbA3lxByVUlq/bK4gWF7VqUC7Z9ieayOCzWVfTiTZuRtz6d5CFMy5Q+W7uHEuU8R318DN9Vj5BmvHXuL0HzFKGVsvv24EaWRaKz5s4mB2XZEWJ4vVG0dqwr2qIqdeCZfqNQvSttXitERqO+0oV+JWxKpMeKw6uATAZe8Wg7D0tKY5Oa7gJRQ9nvTGHBz4+AaE7mdGLiK66nvqixRGCfs5q+AcACPEbQCejjRhdG4fLlwHaH3cfA1o2dU52J9fqAtcxHQeTcbG/+Xt5ER795O2oY8Xi7H5HjPx+IUNi5IN+btFE+SVDcuWfwCJLaBpQE1J2YE+Ga+n8GIUumW+mIc0SirDVgiV6ptRsmF1b+9BuJdIqoh8LOFNXtZHtGRhGB0GsJXMFM5xr+9DNp+chQX9jnmyoHxMQJN1ViTuWU+voNF+WXubYAqDhC/klWc4/MqCiRRZFjfGIVTU7oq1IbQTZnmj5D3bW6Ey0hiT7F5FKbCucCEkJxOdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39860400002)(396003)(366004)(478600001)(16526019)(66946007)(31686004)(2906002)(6486002)(956004)(31696002)(6706004)(110136005)(8936002)(86362001)(186003)(66476007)(8676002)(36756003)(16576012)(316002)(26005)(38100700002)(5660300002)(83380400001)(66556008)(2616005)(6666004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FGPzTySKfbL+3TjTbebLKfDhTFU/29oHETWl4dKUo8lx4EVRh+M+qEeLGgYd?=
 =?us-ascii?Q?KZjCyYMkt4W+AeJm3QQIfNYuDKk3nsoDnT+JbC5J4tFRTXxdpUSXq8OQguAL?=
 =?us-ascii?Q?lHdPVEhvRYCAdnPWxy/5Bu1FYKgU6j2NQMk4lnp6GPNP7JvuqnLKeN6AXH5c?=
 =?us-ascii?Q?gOIYmNtfIcOtBRJael8DATDcDJUcc/uXunAxTUAENrswbHKf8/AmnzPD6sVL?=
 =?us-ascii?Q?gKT4Ntmqsm39OlAFcaM9P4Gop507uMl7gmlJD5nXPNi4VnSvC052ZJZwfiqA?=
 =?us-ascii?Q?tUx14hZyjIPYAl52xFGMg9StNE42ZilaUuaX9PysFsBsFYDC776uZM+6LOAN?=
 =?us-ascii?Q?MPkWX86rpoaTpQRUm4jmxvYr+HYx1y14oEPyHXTPKtmx+vW9feUEdBuYj60X?=
 =?us-ascii?Q?2Ok3z3m4ffnqpH2EhlOjE2VU0HF58whD7cCgFK2PYt1eRvDowDZfsIM2iS9x?=
 =?us-ascii?Q?miJH0mQA5mbjhnQzYxyce5bF/0YEE25Q3Z9c0Z8i5HLpptOtyggcZtnzDUqV?=
 =?us-ascii?Q?/Y4sStvGXxoKWY1ng/7TIHZdbva2Y/T5vXm6DQSfX3IQKao0d1u6fKbQry56?=
 =?us-ascii?Q?vitlrHFZ2BsPZzRJLZo8Py6wVqwrF0aQos1IIRFMrtNj/SoT5BIZTSYFPE25?=
 =?us-ascii?Q?px8sNJgYxP437Z91ZVFrtn5Vs57aLHx3lfksIXm4+40U1FnvJoRaZ3S96AMj?=
 =?us-ascii?Q?ZF7zLR1FVlET3HvwcLOxJG5T5o1+d7okzlCN/L/DJeHnqxf+AFRgnPQMJ5XB?=
 =?us-ascii?Q?jQCZlgtlfM+UG6hwxGV/rpM+mh9Qi4y7Lo3WmQz6ahEwgcQ3NNcbteMpHEFX?=
 =?us-ascii?Q?mmXDGOvzHSkdJUamT4b731BiWntqhIeepKpOVDzmCNYooYyru/tUnSv4EEma?=
 =?us-ascii?Q?isD5yEfVJPEzqyweTXgcUKadtkXyYFrvjgQjYfzijZUQHfe73dNBDKms4zcD?=
 =?us-ascii?Q?PBp1Srv4E84G9a2LwZTejOb56nEla8HDQRvum4HL61EQMCOZRWz/RLNDb7qE?=
 =?us-ascii?Q?nVMVjiUfSIkhsLwCgaUfkICj0teYyFXllgjGwOmRdlkYWRqMFjeYMIcXnRBd?=
 =?us-ascii?Q?Bc6vITUfOkIxTCPFSnIbiPH+8HUqNCL5COUGl0QdKoFkFEtbcWrssgZUVBSC?=
 =?us-ascii?Q?tVUSM3SZBE5S2SN8fO5xi/ZYPVx0Lti0An+KLLhv++BS2g02mSPKWEjSgOTg?=
 =?us-ascii?Q?eitA9Tl+a5sL/g6UBNUf86zl9p7wntBXuDj6bANMnm4GF9VUwSCT71RQxuUw?=
 =?us-ascii?Q?rpjHo8EYem8CpJE6+1peUWCg4rJF68AVHLpgafjI8DkiQfSF24dqiB5CkP5p?=
 =?us-ascii?Q?8lARhjzLYybHmezqPMk56Mri?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bb6526-3679-4876-ca9d-08d93222ab0c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 06:31:13.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOGzDTVTkZWtZHfTpA12pWaclugy+l/cAhz/NIPfDISoux1VnNQr4UWWJLpwZc6W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8309
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Leizhen, and guys in the mail list,

Recently I find one patch removing a debug OOM error message from btrfs=20
selftest.

It's nothing special, some small cleanup work from some kernel newbie.

But the mail address makes me cautious, "@huawei.com".

The last time we got some similar patches from the same company, doing=20
something harmless "cleanup". But those "fixes" are also useless.

This makes me wonder, what is really going on here.

After some quick search, more and more oom error message "cleanup"=20
patches just show up, even some misspell fixes.


It's OK for first-time/student developers to submit such patches, and I=20
really hope such patches would make them become a long term contributor.
In fact, I started my kernel contribution exactly by doing such "cleanups".

But what you guys are doing is really KPI grabbing, I have already see=20
several maintainers arguing with you on such "cleanups", and you're=20
always defending yourself to try to get those patches merged.

You're sending the patch representing your company, by doing this you're=20
really just damaging the already broken reputation.

Please stop this KPI grabbing behavior, and do real contribution to fix=20
the damaged reputation.

Thanks,
Qu

