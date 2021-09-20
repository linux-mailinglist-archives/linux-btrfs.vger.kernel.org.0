Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2AB41101D
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 09:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhITHdL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 03:33:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20018 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230061AbhITHdK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 03:33:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18K4ZNK9005962;
        Mon, 20 Sep 2021 07:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wcCFlpYW6bBKsPpky2A74XoVOBjlMBib0LAEKxCF5k8=;
 b=FKpiDozAJ0jyjgcpsJSiicrz1NrLusRfptweJ0ao/VmYVfzdWyc+T6JDRnd4PMYy3/MR
 uK6olLfu+uI/Bo/v3ERH9ceQAYoDGwmuXxiZW9Y3SGyW6kE453AmMvI2q09XxlRwBfix
 iAG3xbkqaQyJqPhUpt8hMn7VYXX527Jw1iay0M60yWAgvbKdoZsFxUqksq89IV3kajpO
 tlW3HhQ2/JlWhA4rl+Uk2CBS8cjg/DmaPs7j2hWjmYvFedrf6RBRhcfNgJ79Cw2fLxYv
 qaYzNFIcKWaPSRukNNE2ROndFNUibKpQM4edE/Uqboan4B6ADc4Qb7lg+tnIIOK9uUgh +A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wcCFlpYW6bBKsPpky2A74XoVOBjlMBib0LAEKxCF5k8=;
 b=qZBXcYM8JtDYK6WWJkUDOjcGUONT4k6yL91OTvTFEEcdDUO/9pdMl5k+Ac0vw+0XuZGN
 4ExRYrpyGDet64rr1bc1gyl0ijqq20WDMDRNU62R7Sv+AXUlPSENs5s2JQKT+ZRXwybY
 iex85nuFpweIfk/Xvia6/zfPjwStpD2OBWsGVaorqohoB0ncZylg55VY0Jx/9xkj2QGS
 eFKsKAr1dx9mfg65IvBgAfiSLzriiPhl43gDWRs0FbuZHMAt5Y9y2WMq4JiE7m4DNMHq
 CXGx0PuX3yW9ZY05csUTg3gWVd81VIXKxL2ocsW2ccCT1z0WXwq29JtTfkIXTSowh2PW 9g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b64269esr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 07:31:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18K7Ujwc027280;
        Mon, 20 Sep 2021 07:31:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3020.oracle.com with ESMTP id 3b57x3p49k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 07:31:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P695rTs876CfrjsQljvfUUIMAKuQKfwf+s/4qu4AJTTtpLtlsQ64UqwinFdcvsSWX5+Gy/dPzw/Rp6q+TcIUfLoqbbNcdvdi7CW1XS7fuVQm+82IF8LJ2v7259NU+Q/I1p68x0W3FV7jVJAi0Lzc7789CrH1pgS4UTVBtQNUVRxXme4i8EW8ENR9BI0Lq1jFjT5r35u51kO1MbEbBa28Go7srh1yESpuetfpmiSA0xQCWn0Aqxqd+SA29lujRIny3AwnIvp8lWiq1I0Bd6tpDhmm3qnSA3wRMoDek5P/4LGjZj2hSnH1tWpAehbVmh4eehmdyyh521HQpvdXyziPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wcCFlpYW6bBKsPpky2A74XoVOBjlMBib0LAEKxCF5k8=;
 b=R8aOuI7ZfyCMQQAh2Qhmc5FfbjVQ5rvWXYEr1AH9Uun2DSDkddeSCiADGDOrOhjIRchkumxLKccjWVpctQhLKHf/eGhXpUtaeYnF+EEktZIhcr1yrOXMI6Xeusu7ZeBNDxgUC7+SbinHygQqyNkifaUg48F+/wQTB9Wb88BauuGo7jVXB2XxI43fsyJCo5/SnWBi7hRaElc5ZJ8s6h52RbW1t+mntbcl1ETtjiCosg1JPdLPsVgrGKCRQcqw1mi4PClvTb/KcpnCMApFlIPSDmA0QerOynGLJJIm3l4nkxQGXuGIYrMQTfcKUHscEIAnuSJ0hOl7cBHpFSZCA/lQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcCFlpYW6bBKsPpky2A74XoVOBjlMBib0LAEKxCF5k8=;
 b=uS6UWDhuzFqqj/qSPqNnWMF1ClFv/yQXgz/Vo4YBo3+Z4/AjPwMG6PyA5+RsBqgjSrq+occIa85PksjW7wpXFJfj7hN66Zgg9b1e7GAz0odwR426eOZP4Vz7Y8j5MjmpHrFdJhz9GsJ9FRUneaRKWUU7CI2u6FfvcwBd8/13vjc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3983.namprd10.prod.outlook.com (2603:10b6:208:1bd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 07:31:38 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Mon, 20 Sep 2021
 07:31:38 +0000
Subject: Re: [PATCH 0/2] Fix device count check btrfs_rm_devices() and add
 comments
From:   Anand Jain <anand.jain@oracle.com>
To:     David Sterba <dsterba@suse.com>
References: <cover.1630478246.git.anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <3e73820d-b6df-8325-2c98-c3a6ec8fe475@oracle.com>
Date:   Mon, 20 Sep 2021 15:31:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <cover.1630478246.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0158.apcprd03.prod.outlook.com
 (2603:1096:4:c9::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR03CA0158.apcprd03.prod.outlook.com (2603:1096:4:c9::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Mon, 20 Sep 2021 07:31:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed3f0ebe-c7f0-41cf-50ec-08d97c08ae6a
X-MS-TrafficTypeDiagnostic: MN2PR10MB3983:
X-Microsoft-Antispam-PRVS: <MN2PR10MB398398E2D7EEFC89A5AE14FEE5A09@MN2PR10MB3983.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oab+Xj05BtlE6voAdphdzEr7XmN76aehkywtqR7gLNNFO26OK45xklEGQyAxOcw2MRQ+XwkTdEJLvUZHxqd3qW1USI3nNJQ6JqlZ26AFM3sWJV45Z8vNXuUw95AyyXfpDEkWNz57gPe2TbIp4sdPYbJoLVtRh7yYxDTm1ob2GS/8j4dRbbHx5aaBgY5zEqVFIBF5foizosn2TJ3Yph3/fhBmPwKjaww2Wz9diqaF3kaWTTr9ZqSCT+9JiZI4m2owSsl0q5GnFKkfRQBTyewvofIjX2nlXjCnF5twMWZXXC+qkTcsIwePvk402Y7JGo8dmYqpDF5xUWUWAct43/dyTmyoQeacHkimj8BeE+efB+iDXi/dB8ZjUJxUkw9z4dY2bEdwqg6DMwVQJ/g58P/7QkNXC5E+Re4MS5VEZMQ6Ds3mRzlHbV4cd1W/uLa3WPbF7SyGAplUQRsTGwBnkpKTPpFbuPcPbyoaKGcreH33pxqBqmdSKjTZ4CS9V1dYlfUglaG7II6uAMqb60BAGYeF9oPDvrrT63idGFiQ6Dr0NOsZKCK0/Pp+8EkaW0MAsjXoqt5ikb0fuTkwnBO0OG0EgIAprJFRIyKvi0+Vq7mTUVp7ggixyC7JNKhxM3lTv1ei0D4Hazx7LoOeLG5dzo9DWFooX5dgob6wtdmEFdSq9eQuL4b9q/q4FIQfv8tvjkTsinEzYokUahyBQy0tKnmN8D8EQbT9z/DFW3JYhAKFSxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(186003)(8936002)(44832011)(66946007)(66556008)(26005)(4744005)(5660300002)(6486002)(508600001)(6666004)(36756003)(956004)(86362001)(38100700002)(2616005)(4326008)(6916009)(83380400001)(316002)(16576012)(31686004)(31696002)(8676002)(66476007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm9vWkJqc256aVBPTlNJMndDeVowWXlhdEdUM09zSVl1MXF4QlRRMzhyWFM4?=
 =?utf-8?B?ZWJCUit5WitzSytYV09LZVo0bk9BOTZIdGdxR0JScVN2dWlGaWNPSEtvVjl2?=
 =?utf-8?B?azltaGpvODJ0Y1l4bEdtb1ZDOUYyYnBpYjFqYkVISHVsNXRhU01YT2FuMUJM?=
 =?utf-8?B?SjlocUZoY0xsUzk4bkJISk4zYXRjc3M5SXpRN2pXQXg4UE96ZmZ3UDhJRXZK?=
 =?utf-8?B?d2dVblNIcHRNNlR6QlVlTEQySDJyWjg5eXVqYTIvZDA0dDZ4ZzYvRVp3Qm5u?=
 =?utf-8?B?V2wwU1JCcDNUc3IyTEtmMjlOamdlWEV5TGQ1Ym9xeXFmcVk0Q2p5c2NnNGJh?=
 =?utf-8?B?MHNzK2xMZU5ZSDRmM2pmRkxFdGlGR2VTeTJnYklDQjNkNmxsMW1CalViS1Uy?=
 =?utf-8?B?TmdvbnAya2VVSVprVEtHdnVZZCtCanNRRmRhWHRiSE1Lb1dLUGs1cUwveDZL?=
 =?utf-8?B?Zjczd29MR3B2MWlOTUY5YUVDN1VxRHJ3RDBzQWsxWFFOY0F5S2k3bitidVdT?=
 =?utf-8?B?dnFKNENzKzRuRUs0UmRiaVBTUDhiVVhqcHQvczZQY0JwdmxKWFVxMUdwZERu?=
 =?utf-8?B?N0FaejByWVNDaS9qODJFQWVSby9HeGp6YVUwV0xUVHkyOU9ycjFRMDZ6NEJo?=
 =?utf-8?B?dFpaTlBnSUhvZVJBVUNCemsxVkhvdmpOeWVaT0N6OHUwMnlHSUkvcHJDUmRQ?=
 =?utf-8?B?Mmx1Zk13Lyt0cDhHRTBodzdvOXBDWklEUTVYOVkwWmNiTnM1c2E2SGtoTE0z?=
 =?utf-8?B?WGZPSExZenphMkQyem5XK044ZFVvTWxCSmJoMlNIb1g4UnRrWVg1NFdTcUo4?=
 =?utf-8?B?ZXNlTkw2bnh3Q2VYME9rSXhqQ05xSUkyUmFWMGFxUHlRM3NHK3NNbldhbngy?=
 =?utf-8?B?S0owKy9vSEgyb2tkc2V0TkxXUFRYd0UvVGpodGtyRGN2TndhTEJhZ2tlYmNO?=
 =?utf-8?B?NHo4dStMZXVEUU9xUWhqZFo1Y0NHcG4wbmU0enBMMjNvOHVBZmRWSmlkNmMw?=
 =?utf-8?B?UUx3YzBtd0ZTTE84aHpVRk1oYkVwMG9EdUJJeUdDUGRUQVdwSmc1R0Jibm1L?=
 =?utf-8?B?bG5iaS9Va3pTanlKc1N4SFo4dnFpOVkra21ZOWt4RUpsSUk5Z1RsNkliaER3?=
 =?utf-8?B?SXBGOUJBT3hCR2hZYWlDcjg1SWZNODkzeTc5S1NoVWVxZDNWQzc3ODZvU2l4?=
 =?utf-8?B?UG1rditTNHBGc0toNWNidldzQ3c4Zkx3YjE3dXFqVXF0MzVnb05LdW1TaHdI?=
 =?utf-8?B?dXBhRWpWWU4rNXJSTTM3d0RBK3N6Wnc0Y2VSUVlyc3B5UjkzMmtINDhSZGpK?=
 =?utf-8?B?WmxsS3ZHMnlseFBzQXFRQ3hyTVdEbTc5UU5hTWUzMnNkYTBRa011azlCYVAw?=
 =?utf-8?B?MEtlMlZlZm5wQzc4UVNSQytaOWVqZmd1Z2kyTzBaTUdkV3hjUG5OQ0cxTzha?=
 =?utf-8?B?aGFLRklQM042ZStGQWFNRGtoWmVHOURRMjhHSEdXYURVeTVWL09Fb1pjcFNr?=
 =?utf-8?B?Q3U2b09oNEU0UWNQbXIxcDJRN1ZjMkQ4NHRmNTQyQ1UyM01vMFlNQmZNNmxu?=
 =?utf-8?B?a0VrU0wrQzF0djJHWGliZWJCRkg1R244RWc0UTNpKzBTWU01ZUZINjBFTENP?=
 =?utf-8?B?elJHck1RQ0lOUFovcUw4SlJydWJ0NkVUVWJNck5oSEhjTit4cmF4SlpiM1Bj?=
 =?utf-8?B?cTA0K1MzNThIcXNQK21VcGJwZFBqUGN3aHZucTRnYVdTZEhwb2tyL3llVXJI?=
 =?utf-8?Q?NGX6K9w4Xq8vn3G2E/5cNXMS6LqkGlYMJJaHJ6G?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3f0ebe-c7f0-41cf-50ec-08d97c08ae6a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 07:31:37.8725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsWdjDRRfAlK1Hbz6H5y4jHRhNTSynQTDF01LcoITG+y06vFktZQmrdu/+9Qbisb3wsyGAl07XkkLF9DHwmmJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3983
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10112 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109200044
X-Proofpoint-ORIG-GUID: 09489HqRhdXIaglAcAAAio9n3smmYfmE
X-Proofpoint-GUID: 09489HqRhdXIaglAcAAAio9n3smmYfmE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Ping?

Thanks, Anand

On 01/09/2021 14:43, Anand Jain wrote:
> Patch 1/2 fixes a bug that we checked open_devices to check if the deleted
> device was the last surviving device in the seed fsid.
> Patch 2/2 adds comments about the device counts in struct btrfs_fs_devices.
> 
> Anand Jain (2):
>    btrfs: use num_device to check for the last surviving seed device
>    btrfs: add comments for device counts in struct btrfs_fs_devices
> 
>   fs/btrfs/volumes.c |  2 +-
>   fs/btrfs/volumes.h | 19 +++++++++++++++++++
>   2 files changed, 20 insertions(+), 1 deletion(-)
> 
