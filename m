Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2B34875CC
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 11:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbiAGKj2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 05:39:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26182 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236621AbiAGKj1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jan 2022 05:39:27 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 207A9SVj029537;
        Fri, 7 Jan 2022 10:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ZVHFMxDC66Skui6TuhordDdLiFZUCqvrKedVpsRu+zw=;
 b=uTDiMAT4Uih+dHlNTgfaqBkHkfvATgmQhkHGzA+8FfZVszZc2T8ubVNAInCC2lMhQe8m
 3I6dnTHWUrQiR6oTReqET/aQLSFnGNT7FrYbFpFJ7uVxpv4y3q2qCCgZgiNYWyEvAUy2
 6JnqQJbKlMLJ8l98qPR1q9TaX68vS4TopSBFPEAabTmIQUzETn47U9RpvUEbcMcJ2G8X
 M32Le5YpYyKMmZ74WEkWrb94PvNGiw60hSvZB8KLfyvxWAI9o2i+vo1giWXluKBUXVM4
 UIUfPVuiVtgnr+BLohFkDiE9quS1aMScxnoaQfTbF1nJLWGOzcwEv3Z/syL19eEEaLbD ZQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4va1pd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 10:39:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 207AWAnr163412;
        Fri, 7 Jan 2022 10:39:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3de4vxm8yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 10:39:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9YQfpbz8o/k5fGBDEoiSVKPJ7R8NM2mO+tE9pEEM1jM8cHWlP/uhf7EsSOY7KRdJdu/4VKh+137g5mq/zdON/r/A6v1agtwgqVMrQ+fLgSST/g7+WGBIUj5xLAQit+7IoTpLyCfYiYw7Woa8LTBCB42GR0JQYKZ8zJQjsoOqLSj0YJk5Cca++IxpodkwhpU08C4rkSMFod5uPGW0CqbPrgQ+0rekV+o4k33NHKcENnu29k5goOeY7E3p936SK+mpc9GcqKcn3dATwJmyB8zJjEdvjtv7Ku3IabaiFcgaepqaB0OIgBE7kiZaIUVCy1vM2dj2zWpafP7Od0pKNW7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVHFMxDC66Skui6TuhordDdLiFZUCqvrKedVpsRu+zw=;
 b=YcS2hnJRMDBhbdEg7kdNleHDWFG/bzK8fcQO8vVsAzn9lcroQZwN1hiCzJ9m7QIlJkCCg8QydIArLVbr9m/iWgXDuxoQTgeC8rkzptpriRIMiOhPGed1xpQok+v8nOR/k/9YlsTrAJjF09yZ8Fx8DgJ4Dt9k7oqCWoc4lFqC1trTexloi+fxNV//8E3rUuxKwqElpH+I3VSVS6ZW4rEiLiYRst06WRqg5qNcN2LklZvd6UPMrlZL01XK7+JB7PmkU2lEXbEPiaZZDq2DOiOFaQbtrwiIVHPunudqsV74HisQfdFRnwDOGTgJcof0n2DDenX8m8BRmDbYcv0NdvIzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVHFMxDC66Skui6TuhordDdLiFZUCqvrKedVpsRu+zw=;
 b=t/n3a9XvC+SzMGmPHH1Zbzg/Hgz3SDH8eDyPm2xoo6Yo60ewKCKuktepEudzvmNhFGdoyJRrcnslcT3nNqDSMKdHMmj73SF4V2cdkp7xmG8Jo/DoOu+uEyGodfDc/oEQYmF/RX7OlYs69NlycWy9DuSmDKx8s5BOXAapAkSQQSU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1952.namprd10.prod.outlook.com
 (2603:10b6:300:10f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 10:39:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 10:39:16 +0000
Date:   Fri, 7 Jan 2022 13:38:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix double unlock bugs in btrfs_compare_trees()
Message-ID: <20220107103854.GL1978@kadam>
References: <20220107072430.GE22086@kili>
 <YdgVWU9lzrXG7Hsu@debian9.Home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdgVWU9lzrXG7Hsu@debian9.Home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ca40622-eac6-4a69-07c4-08d9d1c9f411
X-MS-TrafficTypeDiagnostic: MWHPR10MB1952:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1952ACFBD7E3D5331D11FB068E4D9@MWHPR10MB1952.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Y8wL/C3gKWtFbKTt1fu2QLJIenGNk1jUo6X3tj5xLyzt9VegFixCAio/5/N5CATyTxVpzGvsNjigksF17r80fKwsrWmvc6oZYjG67GxGkNZOFKLVTjspQWLujY8ODeumvxQggWPM8NhvO0DNC1ecwQ51BuflUO+9rMmj7kAawEVPGyc7qcUAYOI2xGa8xobdheJb4BhM7/ZnkSVtta1somCFrGv5Zobo29r9pkNuwN4OHR/OAel9e0qeD5HtGWEqCQ9b1CeJ7kYrlaxbu6CQpXDSaZE+Aq1a8VqYytUMtb3ZPa2ew3548ffLjRGEisNMk3HgIVFe6lpQsCeJNMsXuYAzyWovvlGqvbuHlhn0hSFUu42RKlyfo2w8ZFCZ/PF3voUgdgKB8KN3vsxKwrkFMHrGsrSYN/PBrKYrNDPHNhPmbuU9AL5pcl09d9zGuD1yroVKYqN3OajQDxvNx+p+MPP+PcKnOcXM2AoXJBzkQjTOFakew5f7HGKSX/f2unUFN1Gun5q9W00cMzxGDcdKdi0j7cygGDxszwZoNLr8Tj4CSF1Zrj0G1tXpwSj4QmqQdH0HtsRjtvrDFG6mkMxVlWOFQ6mrHGgihEjbANbCCQFdPoekNUfHgySoD/x/iiPfQrSKRS0rVCCaHt0YzLOz0IQ0sUg/V3WikL3YIjlMG+IW8JOLwoFG29Slh0Q8i3sKd76rA7qghVsMoxsiZlE90sVwcPpQ/4UgKn5NIu2MvN0ttmOfRn4dYOUqI6fUx6XseIJHBvB+6VitSGxV/6thF5ftve12HKyGLhwU6iRkbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38350700002)(38100700002)(4326008)(9686003)(6916009)(8936002)(8676002)(316002)(44832011)(54906003)(33716001)(186003)(26005)(6512007)(2906002)(83380400001)(5660300002)(508600001)(6666004)(33656002)(966005)(6506007)(66946007)(66556008)(52116002)(66476007)(6486002)(4744005)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/djhaFf82kMFuLsg9WzD7xjQY0AdOokaUcUB7z+xAeXJVOmC/l+UQ46Y+ZS?=
 =?us-ascii?Q?DWGbx3ewbOTOuOkt2ZtuZchI2rBqE/agEsFjRhyorRlLkXGe0ImxZobR0eCg?=
 =?us-ascii?Q?WmbMid0vEmNmc7jEK5oy0OBtLx8bYzRo3AHwEUOEqMtJstq+f+YZ118GwUOj?=
 =?us-ascii?Q?W1GO5z1LpzQrlWDv5qbT8hs0HF0zQt3WkFK76+ETT8lIaWJxpK+8t6rEh/Vk?=
 =?us-ascii?Q?R4tHWWJ5ab2YCXt/ztyo2thH5WwhO4eKyLpd1yaD66y+EERG7ybOle036TN0?=
 =?us-ascii?Q?cshNt53DUliIho07FgJIAhP1jOONLaFUAXFbmv1h+fYHD1jgz0qYFDMzM3+9?=
 =?us-ascii?Q?9kKeFFHXsAiAoPW0Fr20bK9Dx+fML43wSIixDgVaMJ5TCgydqqG3TzU/gkLm?=
 =?us-ascii?Q?b2pjwHPkRkQpYBitetXPUPw8KEu8v8DxUnK5r4yUjETmWCQbVZwGPgchJOHB?=
 =?us-ascii?Q?MoLVvhsdDt9pD9EJQ57TS8lrR2+ltHMr1hHbVzITe3Z854noKRcmhNddRbzW?=
 =?us-ascii?Q?zdx0R5jOLUYxzdf6Ubi+f5m91Mp660mUuPnImgeqv5VJ1pTMdjIb5oIbm+q4?=
 =?us-ascii?Q?/DpImqNdigLewHMWJBWgrgpRwPIY13aT9BCVTmlz7skUvWFnNcGDHR09mE40?=
 =?us-ascii?Q?R1BJFdv+9VC6s4J8PeeH6EOGeKVjjiBnY0ehrGOExnnPTfidQ29USf0etCoM?=
 =?us-ascii?Q?TGg8rydw/p57k11XQfvKPbFMSpvUdLuXI0enUKMwnZw1kg/4g5JFZRPJ9cN3?=
 =?us-ascii?Q?oQuRJMV6i8jTCEF7JpcQNE1KMqu056JT5NF9bzn4JnDo5WUPQykvOoargsAh?=
 =?us-ascii?Q?1Vl7EbQtO25MCCS2yRYwkiWxaLosieqH4wE2dTnv0EOSzIsMzDYH7jNzY/sb?=
 =?us-ascii?Q?aL44lGW++Wk07sCs4OVsiJdkYhQsLf1NFgogXrbxlaB9wb33t6bs8LoQz+F1?=
 =?us-ascii?Q?6LolbkVl6DeWZtNOk90nsY9ZB8kONH+y5QGtsiw08Wo9zzo0sutq+phgk9ea?=
 =?us-ascii?Q?3296+THiY5N9jdlsl9hUuYWpjORNmFBW60ZXufTuDYOYsU5vuI0CIIGj+5+1?=
 =?us-ascii?Q?9hJe0bcUJssxUheQDX8+QB0X6fPJopvjZK2e42ufPznyqfTovRiPZenhJRAE?=
 =?us-ascii?Q?bwr7LdWN9j+eDm5tfBDk/MarSI1sMGt8ZU1ErgWkjIiLUv2qnonfHjqbPaCG?=
 =?us-ascii?Q?EgA9L9Jp4BdJM72xP7KmxsEO1ffRkmi3nfFg9tEMaY+ZUKu6fZLXu0i4ZMqz?=
 =?us-ascii?Q?wHR8WeB2ItgVdjQuj89Riea5b5biYmnTDObiyzIryQw2CObfceGNfazFeK1d?=
 =?us-ascii?Q?Gksm5rndfjWiZR8KfEFu8u8aEXSTQC/VO8louE+Ut39ZnzCcmqULreGDIVMw?=
 =?us-ascii?Q?XTppl78P3t7yDB/uvQFbVL8yW5y8WXZmLf2VE7hph1kZSpDhRL5Nj4+RxqXg?=
 =?us-ascii?Q?wxhRFamWJRE3Mqg9WY8Fo8MmkRJsVBXfzx7go334j0H4td5x/L2so21mno81?=
 =?us-ascii?Q?htRD42i4OUw9mU3av50QbpbHs6BT4Y3Wzc+wLooAf2zofVQewMs4xjB/b5jy?=
 =?us-ascii?Q?2kfv1s7N1dHFlsj0VOAcVc1C4l2kd6JaaonfJoFjmRF5pk8Bf23SMg2rLuVU?=
 =?us-ascii?Q?XmnrgnCbBlYAy0b+wrJE/tMEgFGm1mwCxaatD2oTMPzpD9lXR0aWKy3uyH0m?=
 =?us-ascii?Q?Fm/gC7X6EmLOWQXztWdrSwCQxEw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca40622-eac6-4a69-07c4-08d9d1c9f411
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 10:39:16.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HThxNswYe5nNJDUcVH9GWoJvGzysE1JOSX94HXwrwbjDPzbsLLdE3jtQ7hqrREu+MwEv7zz3yd8vD4F8ynyxhnNVlX3LO8nJuKoS8oGOIRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1952
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=613 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070075
X-Proofpoint-ORIG-GUID: UaK-PhX-UjTV41W_DNW_8k7PRSz2sb7L
X-Proofpoint-GUID: UaK-PhX-UjTV41W_DNW_8k7PRSz2sb7L
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 07, 2022 at 10:26:33AM +0000, Filipe Manana wrote:
> On Fri, Jan 07, 2022 at 10:24:30AM +0300, Dan Carpenter wrote:
> > These error paths unlock before the goto, but the goto also unlocks
> > so it's a double unlock.
> 
> There's also the case where there's an unlock without a previous lock.
> I've just sent out a different version of the patch that fixes that as well:
> 
> https://lore.kernel.org/linux-btrfs/a7b1b2094bb0697dda72bdd9bf1ed789cb0b9b08.1641550850.git.fdmanana@suse.com/ 

Ah! Thanks.

regards,
dan carpenter

