Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBDE3B23B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jun 2021 00:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhFWW5E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 18:57:04 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:52310 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229755AbhFWW5E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 18:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1624488885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iAZ2fZTiGTJy1S8VtD2n8QxgICxLWct4k+I4Ukjyg6Q=;
        b=CduZ2hTh6RFhkvYL54iOlvoBOpNA6Pu80ZruQ96FBFmbcYp4DJEjNmza6CqYOaZ/4fsR0C
        2oSGCyyvt7kvFU2AbBuSQAv+h/wiWlrCuKyqbORSPFbyns8T+IS1rwFaJ7DgNBWBHcfUyr
        6ZxBNZ64ONQozaJq7MRhbPn3snntmCo=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-_tqgSEKPPL6rmNWbTZoE5g-1; Thu, 24 Jun 2021 00:54:44 +0200
X-MC-Unique: _tqgSEKPPL6rmNWbTZoE5g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVsRE6ZI1FAv0lDPQyiwOnsJ3OMi2/TpxmcHyj1L7r5vYepLhpFeZviENqjNhTM9VzJzARUxjQVtG4yrfJagOTSyJKwNClN0bpqjHHqiqOUMHHOQb3qnnFTak+31Dfi1X55lSem8T2Ikiz+vkUL7oN88EnldZKomeFKMx8vMMGsouoO0J3rR2XkJa5IeNmAQVNHp4QH3ImnS/8HGiVborddO+Ip2/AQCz7hQnsN05DBmG34dVo/aNoaI9gbpHezdJ2PUcaBFE4WHNnnGMzcaIC22vd/ayGqIyYi1ySPemyftx58NdKSgzwbz2l7o+n5bwhiGzACsVy4mRCdq+nggAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mLOd03RLsopuMb+ex66Bb2nyEmhNveEetWrjRtQYyQ=;
 b=ADJfKZPq3RdYifhd1Z7MyiEO5A1DU+jv6ABpQ/4+IvoBURywr1sR5xmvE0jpt3j11+wp/SNAknRxURh/AiG2ZI3Xes9xzO61Jxd01mEGkrmqgxbNwWhMPUhnWRDHFFVekWbe+L9/206BoH/dvCu8EiOMZcE1KdIdNP6gRAMcrPdgf8W0QlwSQV3FRdmeXllmo6it8LNPNXRWvsdZ2opxC/3sd4M+BGOct1fO5rdFDqx1uEw3annPKhdXHbhq+S+vEJ0wZZLvOidsO1pR2b+ZskHriodADXD7zAUQ+YSZ2lVWNrPIDNTrkiUCEbF1/UZuCaLWF95E87BQXM711qxBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0402MB2788.eurprd04.prod.outlook.com (2603:10a6:203:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 22:54:42 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10%7]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 22:54:42 +0000
Subject: Re: [PATCH RFC 0/8] btrfs: experimental compression support for
 subpage
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210623055529.166678-1-wqu@suse.com>
 <20210623223740.GQ28158@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <860ea877-1986-c6c6-625f-ea3e2224c676@suse.com>
Date:   Thu, 24 Jun 2021 06:54:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210623223740.GQ28158@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::24) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0083.namprd05.prod.outlook.com (2603:10b6:a03:e0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Wed, 23 Jun 2021 22:54:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b5e31fb-7cc0-4621-c79b-08d93699e377
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2788:
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2788E038EA5F0B8BE59DFFCDD6089@AM5PR0402MB2788.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +X2iwjFKdIIqfh8H6lvzC1lfE0UZwQibjlWy7cXOALuOvcNyweZuT0hSgnldHHTtprjbJfTtEX+mMf8TkIgG2AJq2boJsuoFDIIy+4vBQLq9qPzZA7saAFvU92tlNWCAO/ogUeGtzelbkG/PShp9EP6gjTUuTZXhrXrL7A+TIiF/HNmOk0B+IX5GED7RS35JkcXuirPMQMuuSZlbvH5oTDmfqVs7x+uy3ctoNWrj5MfM4GbhYE1AmIvTlk9EIMJ07PB0YSKu7llb0T2zFK9yz6M3vXxGC6llCYXc0Qo4RaJ/BFTCE/PjAPG91o2eFOTfCVkxpDbRFAoaBeF8gdGuCnw7/6GJcWUSa2M2g7qQhWdMcsVNvkO7DxgZuTXLqZmPaDbQP51OmnednKk3SyaH5/dW2zjvmtAVvpdmnrd0c1GHS+52jSEhGauOIx5PPX7ih5BXJAf7Sg/Uy6EFZ/zzDIIP4FPEGu4QKo3eZHkpT9E/vi/EgNo47UUWuc5cMSc+gRLiughmZDpGmrpbjgI379YmkEalFokI7NpgNncZb5fb2+/jT+hxX24qOWPmheU5bvTUDYHfIon9cZ5p6PW2EpwyQx1Rg9cP6iJusYVB7Lur5uILwT1nFSk+0UbnMfjhgmyxjbbNO8iD6QpOJ1KDx9D+GRaF0h4njV/CB4ydAOEOmNsA2MuoTEnvmQA4Mt2c1Y2arDdJgCJOx/WdCguhow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(8936002)(2906002)(83380400001)(6486002)(26005)(16576012)(8676002)(36756003)(316002)(16526019)(86362001)(186003)(6666004)(956004)(66556008)(66476007)(478600001)(5660300002)(38100700002)(6706004)(2616005)(31686004)(66946007)(31696002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZDOoYNbp/nMf8tNIGKPNXo35c+jIaX6dhqLX4CC824d8fEoUG2PJLsAWwodU?=
 =?us-ascii?Q?SQ4r+lPSVrfVR8HFGoatcHNqCcQctrYfaamnWPE9tVjVwS/PIPp7GPEVpSgq?=
 =?us-ascii?Q?WPF2HuNWlK1sE2DEiA1fl9jYS4qQe4CMvW6R8zZbiRwp0JuG5OWheqGmjvxN?=
 =?us-ascii?Q?SAH1X2vwK4IcYqYS4STIjfKelSd2RP5NI2yHue2Ugiscz2zXnYtla9FOBvLd?=
 =?us-ascii?Q?lhfRQZHIi7h7suEdhP51IBQKqdvgP5yauRNrrO3oYrww+lMzVGdxIoUrCV4b?=
 =?us-ascii?Q?02UY4zfJ4Yua36Eajko1sxOQO2tHql1X20rMmgkU3tsxC5em64kZik30nX+V?=
 =?us-ascii?Q?ZsBbusOaDJULRcO91v5HS53vUnjYQStXuoMKJp5NZwwfKp/WsPDybbZRDAZs?=
 =?us-ascii?Q?Ns/Bb1pbP1U/pLRI7s+Z5QFcjl/UkPAhhHUW9nF7lbYyg9nh2ITesJWCGSBJ?=
 =?us-ascii?Q?d9KFuhWWdgGaNhu+g4z7yQR3gaGNcME5mwJheb3962ffqXc9DFuoLKzLJQ92?=
 =?us-ascii?Q?b9KE88oPh+IEf80Lk723O+n9Q+HcoFnkZaiuyExaf6/5vaHfDWbimZeJYJVh?=
 =?us-ascii?Q?escrEutgGOLVO1OfTrotFXT1GuUxqbXG2bqPL0RHM9oK1VzNRI73/RxecInY?=
 =?us-ascii?Q?7fpKNvnwxKT+BDJPg2FHnfLrwqax65A3xj6gOz0flCsm2EwaBQ37iP3AAPEO?=
 =?us-ascii?Q?iy/Covn5cpz/kQzzXOWNpYMH1/RKq9shXry4G+bkJbTPB7p59jk3AC5RI9y6?=
 =?us-ascii?Q?2wJQVU112cVdkQY3Ciwi+y0FM4wVNieS5rkI+m7PsC+oBqAo3nyjow3Ytyy4?=
 =?us-ascii?Q?pKt1yVy84R9mj9VPVBPpBZdC3qoCMGKNnCQl18j6yz2Efc2WwgNnwh8RRf6q?=
 =?us-ascii?Q?mfhfHWVVQl4hne16iwArDxdsnYzUuXvKyzWupXZfEKUIaMH/b18wyD287djU?=
 =?us-ascii?Q?RThRXv9O6L2yD8Dd1f23Y7k6RXc2PhSFEJt8m0egzsCQFfbQ3GdiY8cLOeOM?=
 =?us-ascii?Q?jGu+Hpt+2wM8E7Mb7EgpLnCs1mJMB8kJDUiag/7mrFzsPNH/4PEbpjVR01bY?=
 =?us-ascii?Q?vS8jE7Oge9bawmiuhklvCFoMdkXIY1JtMCpn64QucgbxyJWUY0k0qHws5XSM?=
 =?us-ascii?Q?+y7jyG9vMoxQuGEg56t4pSixeTB9zCtcVfo7VlFQ/nRRHxSmdnHPZNlNqQaj?=
 =?us-ascii?Q?xZO7pSO13vZX/48yuRGbHZvdoOiIAoYIlfCzwGZroXbGP1GU3ONFNdjLvAeY?=
 =?us-ascii?Q?oDMX8JJyct7Sl+jhI+PgR3pTWAgcbSvMfmvnCaCaLeu3bOWUcHCsLs01Yi1m?=
 =?us-ascii?Q?9fte3TGgYdDw/MnKEe+jFwCN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5e31fb-7cc0-4621-c79b-08d93699e377
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 22:54:42.6219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XV9qM9rqpozjqikNGxjvfKTxyvjRw8xqtc3WKTNaqXDt2dS1EVDyT8AoA960WtVO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2788
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/24 =E4=B8=8A=E5=8D=886:37, David Sterba wrote:
> On Wed, Jun 23, 2021 at 01:55:21PM +0800, Qu Wenruo wrote:
>> Qu Wenruo (8):
>>    btrfs: don't pass compressed pages to
>>      btrfs_writepage_endio_finish_ordered()
>>    btrfs: make btrfs_subpage_end_and_test_writer() to handle pages not
>>      locked by btrfs_page_start_writer_lock()
>>    btrfs: make compress_file_range() to be subpage compatible
>>    btrfs: make btrfs_submit_compressed_write() to be subpage compatible
>>    btrfs: use async_chunk::async_cow to replace the confusing pending
>>      pointer
>>    btrfs: make end_compressed_bio_writeback() to be subpage compatble
>>    btrfs: make extent_write_locked_range() to be subpage compatible
>>    btrfs: only allow subpage compression if the range fully covers the
>>      first page
>=20
> Some of the patches seem independent and potentially could be taken into
> 5.14 now but I guess the whole subpage could go in one big batch to 5.15
> so it won't help you much anyway. The significant change is the last
> patch and so far I think it's acceptable.
>=20
Nonononono, please don't merge any patche from the series.

As the patches are not fully stress tested, and I have already seen some=20
ASSERT()s triggered, thus there must be something wrong in the=20
preparation part.

Sorry I should have added some warning like "WIP, don't merge any patch=20
in the series".

This is mostly for the discussion on the last patch, not really to get=20
any patch merged.

Thanks,
Qu

