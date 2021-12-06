Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6494D46A4A4
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 19:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbhLFSe7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 13:34:59 -0500
Received: from mail-dm6nam11hn2231.outbound.protection.outlook.com ([52.100.172.231]:19671
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233544AbhLFSe6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Dec 2021 13:34:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIHsJzibbDh+s0F9pimmU6x1KOwO2JorUTqsWVpBeEsWE+4Umn+FpQ9E/S5ClgCfpU5+kdOhtEXKnYISzfVc12OHXAhGikMI3wcE0TAMsddpdqZp3LjNpRU9ZuQXYIti3MBS35yEyta+4K+qwihmz46oVBKlaNM2wPPJhh9MhjWhmrfqC2YpWdDdXXsAfFLYGeBfW98+c+17KsDFBjnmwPlWKqQCtFj+Cqy/Atj5dafOMsO4Y5lP0MD9WaJakF9x51idzOi2zusv7y8sMjrE0gYIVx8k4WSaP7nmaWDJNPjaYZEM+eZzbTM7mJNiooKZqI0VtHy/VSWiZ0Z/EMf6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTkULZ5UHExQp4+lt+mjKcEqTWLs4cv4821EJcQtSYE=;
 b=kwx24YP90RtwIFfx3Lt1u9Flt8p6+/fIBTAPR2pHB+Mimj4p+eOcdJv99gMb2/oYEbqobdXHKQH5fswxwaxI2MbbEqFBcAG1xdp9qnQCzguFR/KEZq9JGmx1BTII3wzI2AUCVhgkl+lcsiGgX9cZdYcvfgQrCbh3zkr24gRvzikybZFJ8O028MGXvY7Vdc0oGAz1GHTkb2uSqsSngzM0ResttYADwlZbE4PbPKNfEDRRUIhSWQs3JLT88a2NxsOyfBIMUtMaMJcyknP5BwT5n27U7QytnqT9GLsa7hudDseAqWMWSpESnBpXuqkfh24jTg6IOTJKU6X9+5utMqpkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 146.201.107.145) smtp.rcpttodomain=santascenes.com smtp.mailfrom=msn.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=msn.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fsu.onmicrosoft.com;
 s=selector2-fsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTkULZ5UHExQp4+lt+mjKcEqTWLs4cv4821EJcQtSYE=;
 b=YVoi/PC6hmSRvutd8lkgjLyUgBFZ1VUPURuwvy4TOBEYHjYfDBv8/VzWKnahTbXJGp9CtFyKDkq+pM9w0W0PNOUz3JlPr7Nh4P2Xv9/WLFVhKtkkSwzUUGQSUqLOlARXZ4+ZbeWzGXdBy3hOmWS/uOk12Um9FGAeu5FQPHbBn/E=
Received: from MW4PR03CA0009.namprd03.prod.outlook.com (2603:10b6:303:8f::14)
 by DM8P220MB0472.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Mon, 6 Dec 2021 18:31:21 +0000
Received: from MW2NAM04FT055.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::1a) by MW4PR03CA0009.outlook.office365.com
 (2603:10b6:303:8f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Mon, 6 Dec 2021 18:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 146.201.107.145) smtp.mailfrom=msn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=msn.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 msn.com discourages use of 146.201.107.145 as permitted sender)
Received: from mailrelay03.its.fsu.edu (146.201.107.145) by
 MW2NAM04FT055.mail.protection.outlook.com (10.13.31.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 18:31:20 +0000
Received: from [10.0.0.200] (ani.stat.fsu.edu [128.186.4.119])
        by mailrelay03.its.fsu.edu (Postfix) with ESMTP id E7B18951A0;
        Mon,  6 Dec 2021 13:30:39 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: From Fred!
To:     Recipients <fred128@msn.com>
From:   "Fred Gamba." <fred128@msn.com>
Date:   Mon, 06 Dec 2021 19:29:58 +0100
Reply-To: fred_gamba@yahoo.co.jp
Message-ID: <e05181b9-632f-4539-a918-90d6fb3cf745@MW2NAM04FT055.eop-NAM04.prod.protection.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad225b6a-b625-486f-048c-08d9b8e69981
X-MS-TrafficTypeDiagnostic: DM8P220MB0472:EE_
X-Microsoft-Antispam-PRVS: <DM8P220MB04720A6F1CA71CE9E46F80C1EB6D9@DM8P220MB0472.NAMP220.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Forefront-Antispam-Report: CIP:146.201.107.145;CTRY:US;LANG:en;SCL:5;SRV:;IPV:CAL;SFV:SPM;H:mailrelay03.its.fsu.edu;PTR:mailrelay03.its.fsu.edu;CAT:OSPM;SFS:(4636009)(84050400002)(46966006)(40470700001)(47076005)(3480700007)(82202003)(35950700001)(336012)(956004)(8676002)(6666004)(7116003)(2906002)(2860700004)(40460700001)(5660300002)(82310400004)(8936002)(70206006)(70586007)(356005)(83380400001)(31686004)(86362001)(7596003)(26005)(786003)(316002)(508600001)(9686003)(6862004)(7416002)(31696002)(6200100001)(7366002)(7406005)(6266002)(480584002);DIR:OUT;SFP:1501;
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bm9KOStVVHk5TmFDeDlhVmJERnhuOVIyZVF5YkZ1VlNwd3VKU1VYNEk2dHVS?=
 =?utf-8?B?Y3VCWnVKcTR1NGZORy9jRUtxSHk1VHZJY2J1ZkJGVXVnUExJMi8rcytzSVJT?=
 =?utf-8?B?SkFid0hTL3YvRDQzMktqZ3B0bTdCTVVrdmlpbUNSNHdIeDhYZWY2eGVoSWRn?=
 =?utf-8?B?RXk1bGREYTk5dFhHNzgxOUdVdE8yU3VyMTVMS1J3SUhTWUFBU3FRR0ViK2hH?=
 =?utf-8?B?Ukc5ZW0vbnhhRXlKQUwxeGErNmFabmlXaC93SkVBVEpoMzlnZm14eko1OXZn?=
 =?utf-8?B?MVVmUElKdXliQVN1NEJlZ3dPTjlsK3Z3U0NCeEI5SEhTUjFnb2JHTmo3Z0pS?=
 =?utf-8?B?TWNEZXFJWTkwWm44VGVxMmxubGpJRFNSd3B2V1ZoL0ZBNWFYYWdlWkVkYlF2?=
 =?utf-8?B?eGMzU1grR2VRQ3pKOStOeXVaakZXeThObGRUbHBpRmN6eC9uejZIRFBpb2Ja?=
 =?utf-8?B?VVZjZXBEKy9GQzVRSVlnWHYzdjdFYUhyTExxNnBvcW5LSW5QREFOeXkxaHh4?=
 =?utf-8?B?N1ZtZ3lvS0hGVHl6ZDNRS21vL1BMckY5ZC9ocktGWmpmVEwyaG5lbDNLZ01h?=
 =?utf-8?B?NU5GUmpocjNIdStpcmV5a3BqeWVBMXFHMFNrd0REOEFyWG5zbnVjZzlvRWJQ?=
 =?utf-8?B?aWtLdE5FcHVMdzhOSGV2WUhiZE5ydGhOU1JHRmZOSFVoODFSU2ZTZHRCMHQx?=
 =?utf-8?B?K3QyakFpbjA1SWVOM3J4VU9DbWpRc1R6blVwbU5kWVBCL1pyendKd1B0Skpl?=
 =?utf-8?B?TXBYMTVYRlFnTmZmWGRqdkg0Z2pCMHJDSHRWWm1mYlk2ZWJtNzZiaWkwRzZG?=
 =?utf-8?B?aHpaendpRFdXblUxUnBMT0lpZFVVWUdqNVpiWUo0QWNHVU5Pb3ZoZE9TR1Nq?=
 =?utf-8?B?ZU95Z3RXTTMrQTJQNnZHZ0FtOVVidXluMmtESGNDN0VZS0RqMGlWQUkrTTBI?=
 =?utf-8?B?MEptYlZ0bThBNEQwelZSS2FYeEp1aWdhaEVJbHFrTGY3UTh2b2xiSEliZzlz?=
 =?utf-8?B?UHI5OFp1bjhTR2FYMG56SFF3aVhNQ1lET2dscTRRRXlXMWo5ZUxhT0VLVkVq?=
 =?utf-8?B?bVRXZmdTTW5ja2RKOGlrR0VCbnhQeXdJMi96VGRsc244QUhXTXQ0dkNJb1Y2?=
 =?utf-8?B?NmoxL1JvWmNQc0NrUUlwRGpBdE0xRElJY1FhSFkzd0o2NklFWFZGcDRJRUcy?=
 =?utf-8?B?YlNwM2MwOWlBNFU5eXk1ZXhGcWkycG9rSHpWaCtpaTB6c2xTMTVVUWhJU3ZQ?=
 =?utf-8?B?bURKdXdnanNHRVI1TjUzM2x1VnU2TlZjRXR4ZzBHRllMekg0ZEVOMHVDOGp3?=
 =?utf-8?B?SWhoczNvY2xWMGc3RUVxcnM5OEhMamdFSDlKRGZQanRwS1pHMGsySlZnTHJ2?=
 =?utf-8?B?M2pOZWU5RDVtNkhkVG0weXpoL3dVYktlWlFpUzZNNUxLQUZyN25ZMjVQSXFP?=
 =?utf-8?Q?DqhXZeim?=
X-OriginatorOrg: fsu.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 18:31:20.5119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad225b6a-b625-486f-048c-08d9b8e69981
X-MS-Exchange-CrossTenant-Id: a36450eb-db06-42a7-8d1b-026719f701e3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a36450eb-db06-42a7-8d1b-026719f701e3;Ip=[146.201.107.145];Helo=[mailrelay03.its.fsu.edu]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT055.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8P220MB0472
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I decided to write you this proposal in good faith, believing that you will=
 not betray me. I have been in search of someone with the same last name of=
 our late customer and close friend of mine (Mr. Richard), heence I contact=
ed you Because both of you bear the same surname and coincidentally from th=
e same country, and I was pushed to contact you and see how best we can ass=
ist each other. Meanwhile I am Mr. Fred Gamba, a reputable banker here in A=
ccra Ghana.

On the 15 January 2009, the young millionaire (Mr. Richard) a citizen of yo=
ur country and Crude Oil dealer made a fixed deposit with my bank for 60 ca=
lendar months, valued at US $ 6,500,000.00 (Six Million, Five Hundred Thous=
and US Dollars) and The mature date for this deposit contract was on 15th o=
f January, 2015. But sadly he was among the death victims in the 03 March 2=
011, Earthquake disaster in Japan that killed over 20,000 people including =
him. Because he was in Japan on a business trip and that was how he met his=
 end.

My bank management is yet to know about his death, but I knew about it beca=
use he was my friend and I am his Account Relationship Officer, and he did =
not mention any Next of Kin / Heir when the account was opened, because he =
was not married and no children. Last week my Bank Management reminded me a=
gain requested that Mr. Richard should give instructions on what to do abou=
t his funds, if to renew the contract or not.

I know this will happen and that is why I have been looking for a means to =
handle the situation, because if my Bank Directors happens to know that he =
is dead and do not have any Heir, they will take the funds for their person=
al use, That is why I am seeking your co-operation to present you as the Ne=
xt of Kin / Heir to the account, since you bear same last name with the dec=
eased customer.

There is no risk involved; the transaction will be executed under a legitim=
ate arrangement that will protect you from any breach of law okay. So It's =
better that we claim the money, than allowing the Bank Directors to take it=
, they are rich already. I am not a greedy person, so I am suggesting we sh=
are the funds in this ratio, 50% 50, ie equal.

Let me know your mind on this and please do treat this information highly c=
onfidential.

I will review further information to you as soon as I receive your
positive response.

Have a nice day and I anticipating your communication.

With Regards,
Fred Gamba.
