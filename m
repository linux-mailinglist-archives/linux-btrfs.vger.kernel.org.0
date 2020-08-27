Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F24254650
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Aug 2020 15:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgH0N4X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Aug 2020 09:56:23 -0400
Received: from mail-co1nam11on2082.outbound.protection.outlook.com ([40.107.220.82]:20224
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727924AbgH0NsX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Aug 2020 09:48:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjxqYFkcicvP+KCsjy9TCosOYSAphtQ3aYKnWjoMccycAKHH5fNkHMFAtB9w9DViVKmcy2Kjiuy0GjduA8bYzFKoNalH90MQK4mAEat+Sn7QvgEP/BR+kY4nNa8igEhU/6KwlGaxxeYaSEf56v+ssHWHuOr4WRmK9P/JXXoEx3CJPD0psLqaBHeGM3FNt+OXO9A0clDFK2plnXGd3g8FQm2u/3TLR/pvqW0X2QGSUFUB8Eusgb8VEgmkcbZoQAiDKCbwSE4fIVMMNyYaShXrKu8jZIO7S2udhwo8ElbD136D1ye2eVPKq/rsJ7tNjY6BTwU1ccb3v0BOKDxftr+83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1mdq8luYD3JDamGHIeR31L2WAt/mif1LGsnEUmHOtY=;
 b=msY9e2OcMAHUaWowpYl6LwNH6iXl9lXNj4YL+EZDzxx1TdKOmb0VHn6jBJYEReCOxTntF9TlWLojNujasNT0Rs4JqG1ncDOE6FVPktZhh8AWpYMc7sBCt9leBMe+pXG670lXvlF/1T98areR8ubsFmCtkBNEmQkStL+ekyKr2vTYhsOcya7iPJk2PWWiucNss5LMeV6Z2WM093dAFUCpG0HlolNASYZitaAL11+BYpoxesvfNcuu3/LwEVwDdUMHUvx3GekCvOnkLlHLhJDolj+zoq6Ily/9eLpHIX/ihssfGk+g3x+4Cd4B/hYRv1zRh6gK91SPBaHnmC1xazMtHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1mdq8luYD3JDamGHIeR31L2WAt/mif1LGsnEUmHOtY=;
 b=SCPhdCxadarcqyLHk/UhrZSCEMogj8IFE+D8+00kk/xtc1dDFWZyYPhMaiRHk+9NqVYgPTygNVjwchcgIIg+rEUwNPFtihCcn3BbKd4ScfCyCPMAZJHBIVl92h6YVoF2GvxnyGGV51xueJJXcNzAeRIaNaIPAAMAHXTZKVQwBvk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=panasas.com;
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by BY5PR08MB6197.namprd08.prod.outlook.com (2603:10b6:a03:1e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 13:48:05 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::3819:8560:afcd:bc6c]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::3819:8560:afcd:bc6c%6]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 13:48:05 +0000
Subject: Re: Log corruption/failure to mount during powerfail+deletes
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>
References: <33a0b9bc-8cd7-803a-2322-54014703d263@panasas.com>
 <7715d58d-4a89-8c0b-c6ac-b7f6c52f6335@gmx.com>
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
Message-ID: <4a77f79f-5561-a64b-bbd1-37da0f6d278e@panasas.com>
Date:   Thu, 27 Aug 2020 09:48:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <7715d58d-4a89-8c0b-c6ac-b7f6c52f6335@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:208:234::8) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR16CA0039.namprd16.prod.outlook.com (2603:10b6:208:234::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 13:48:04 +0000
X-Originating-IP: [96.236.219.216]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ea782e5-98e6-4993-c062-08d84a8fd2db
X-MS-TrafficTypeDiagnostic: BY5PR08MB6197:
X-Microsoft-Antispam-PRVS: <BY5PR08MB61978F8878426B6996EDDD9CC2550@BY5PR08MB6197.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nPLxJ1IxW0AaG8uc7A96loQqVjXNlRrPwbl8ktFUVVMduDnUFRrdfL+nS6ZXbqjT0JK1UjP+V9kOnw+BwMSx8xoEC0oqcn+r9AnzUg2R9/Mn+lsy/lPUvxFSHzdaz/W6In8yVDl0/GNKAHQdzz6XexZSWVH7IpDZ0MFz88YQ9tL+q49kO5jCH9aaalzt2xAEIv12Tr6KpOx6R5k6ndhQtQYvTgUGO9FlqaXoAYekYX3Bym7EwkET0wIXyiiz95XO/ujUTur58lRl3xIwp45TxwLaXj4N5tpaMc/V5vtqqS9wEzxLNO024wIwWW3xF2BFlvXBR9OhfgpUrU1vdoRuIMhPcu8OdQE7OOmpZQ2lcj3PaDx1Wsggv2T0E8HZnzbI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5109.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(346002)(366004)(396003)(376002)(66476007)(5660300002)(66556008)(186003)(53546011)(86362001)(31686004)(66946007)(52116002)(2906002)(316002)(478600001)(8676002)(16576012)(36756003)(2616005)(26005)(956004)(110136005)(6486002)(31696002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +mWQ2dh9hC/DyShdEnt8LmSjpLQMsMBsP58nPVJjbN1Gsp0n8ze/PlmXymzOr2iwZj659lJ5VO1SEjOYolMMd2lEEWwXYfBHBWrbCmNtRRr6Y64H3IzUSShjorP6envWxAt17wtPt5WK+njQ1yyMF89MTfaELl+x8lNUXrvRhOgH1+jJa7dihJ8YFUFFH/KqvTsBvDI9oQSFS/rJ3KNn2jaheA220/1pWZz8WlglTVFDxYcoQlNWjvSi/9GQnGEZ6xXIEswHdCBoetGpBZ6hFlsJeZRYraKnb7IHti0MMu00xjjHpUP9QB17M2RHSLW0HZ5/qNK/oNFwWp6nEJIuONGRar5UgGOLSyAdlR4BE7B0ncfDNz82031TUavz3/Ed48FDD4lPeI4VKXvsSiNqg+0H0J3VC49+9TRTDG+GloTXGXNRWcRvKgkOUUi8+Jr6HyyZLgD1vmSdReMf/Lq02ei/cP5DUk0QP7iWVPNTyex9clFtrv7TcqJkq9Q/fEJZi7Z+lKvpXkFvNiS8T2fo8/k+sE83mgnk93XMMCVan0VLCjqKB71Kw2JF/gB/jh6l6Wt55/QNzk04ryI2+C5k2CXuN6j+S+RWXqlUE3piqMRrQORqA3OGM8L+83I/sO5e0EcgQLhtO659P/Bn7JVT5Q==
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea782e5-98e6-4993-c062-08d84a8fd2db
X-MS-Exchange-CrossTenant-AuthSource: BYAPR08MB5109.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 13:48:05.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30YL+tYw7JOsnoxNew8BUmfmwizigSbGbdklB57uE7DAB75+SGDyhYZk+RqhU/S1gH19NfsDXyPiQUIjuEDsSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR08MB6197
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/26/20 10:19 PM, Qu Wenruo wrote:
> Log tree can be skipped/zeroed out to continue mount as usual.
> You just lost a very small amount of data in log tree.

While this is true, without knowing exactly what was discarded by the 
log we don't know if a file on this BTRFS breaks parity with one on 
another storage device, which is relevant in parallel file systems such 
as ours to assure parity of the entire file remains sane.  We maintain 
per-storage-device write-back logs to cope with power-fail ourselves, 
but once we fsync these to BTRFS we expect those changes to be fully 
stable.  The only safe recourse in the face of lost logs for BTRFS on 
one or more nodes is full parallel file system recovery, which can take 
many hours to complete as you're potentially walking over billions of 
objects and petabytes of data.

> If it's not the controller doing something wrong, I guess Filipe would
> be interested in investigating the root cause.
> 
> My wild guess is commit 4203e9689470 ("btrfs: fix incorrect updating of
> log root tree") didn't get backported?

Having checked the set of patches in 15.1, I can find no record of this 
having been backported.  Thank you!  I will apply it and try to reproduce.

Thanks again Qu!

ellis
