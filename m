Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D7D745C03
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 14:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGCMQg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 08:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGCMQf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 08:16:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0A9E7A
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 05:16:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363AU5KJ031964;
        Mon, 3 Jul 2023 12:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fHuORNWQeOaUCA85poH8PJs68jHVsSAqnBooeoh8yyk=;
 b=EZjb3WDeyfDxwaUDdQP+e/k15lS/PBwPjdXzi9HbCYt4l8AX7c270PJEtLEiVMAGfebu
 gVVDD43JQVQfVLbXyHqAERRsTu5eAR59/c7S7j6nCWOwgB7WIbu1gfKB5wiov6XdyJZl
 BG3mhpXbWQoAumztyhnOYN+vL1Ho4efqgGxZJALiQ2NUOjRmx0N2OCXzOZDfWU7gzgdQ
 kKT3vHri/EJEuhQhgwf+Srg8/5zfFqjJ0rzSFH4aHvwq58W6S0TpKYQn/OM7mGSGBY8o
 f5i4NldDdN/R994ftOvNJ84lmvNQZNfXLN4FFXCP+itgS3I5G0PVwhXancXfK08yJIHz Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjar1aj33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 12:16:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363Bl6pt010924;
        Mon, 3 Jul 2023 12:16:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak38tr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 12:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUvuJ8MayTTJU2oC1nYD/qm6FKIhBEhWUoWOrYJ4UzicnAl0Cs3seXuUFY8KwDVmx/8qqXf/0APz/JHccKA1i+mK8REGEFU5pZKCdWW5ebjUp/XkLbrZG4BDISD6NPWsKDvIgzWFqZ2Rp9Bt1iLsjg9qmCREbG8q4okvaPhrXbEwhfOxqWZhxGwXyNA2lwiBWRh4Jeal88LeREJxxARlg+eYHnxUDNcIxk5bzDFXuMZALpTGqnBUavildLvF8bNzGS9lhxda+iLMVDE2zMh4zOVbaMxFKH0ovFIf0hlncRUQfb/edi5/Z2u34PwvQWKg3DborUaeaCjUrS5FQtIWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHuORNWQeOaUCA85poH8PJs68jHVsSAqnBooeoh8yyk=;
 b=BnZ2JlJs5oiEd2t1Z0U3otSW4/wZfeXOuZAinvh5/Aqg5WktKaBY6kuiLe+xccs3RXjBQXx/Fcssi1v5oqhRbRQDUJWUJwTv1RBr0EIwA/FRlOsN7b5JlXimnGIBsdEr9UWqmJ4T0styJ1J9wJ7qc7FZVktr2DmSraVMp5cZQETHEC58Fw3CQbMT7QNmipZmsRCcXlyFOUGAcl+wQZrY7mkcz1wB80bEaE3RdLdgZasLpgNbqc4fO8dRAGU56fGDaqNJnC1XkNgCvsOycg0pvmLfhkpB4tKSYnRdX7l19WgdJMh/NNFYbHwHLzK9tI6Ikxvd8dokz+xYBJiaPT14Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHuORNWQeOaUCA85poH8PJs68jHVsSAqnBooeoh8yyk=;
 b=wO713wP7cLPVx7S2FKRKX29CvSZVVhPuLjVVm4fTpC04vWOkjZukxQnV54/ZjA+fY7U3Thjp9zY9+ang410ftDPWNmbDaZxGZpOOgCGMo6A3DwgKMTHFK4JJRfP/GghlpbaTckYEz+W3LGW6UoWsqkRUG/sh+wciAU2RuUd0Hdw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7187.namprd10.prod.outlook.com (2603:10b6:610:120::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 12:16:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 12:16:11 +0000
Message-ID: <b04e6b97-b10a-c0bd-e26b-53394764e9fe@oracle.com>
Date:   Mon, 3 Jul 2023 20:14:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs: fix leak after finding block group with super
 blocks on zoned fs
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <92dbe59fdd79544067340f09449e6fdda0902ff5.1688382073.git.fdmanana@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <92dbe59fdd79544067340f09449e6fdda0902ff5.1688382073.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: b20966dd-7dd6-47db-c340-08db7bbf4999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXvaWhhLMKLT+7ANPX5WgnRJGHlH+n+HwmS0tJCKmXswbJ6cdVYtTvOPKiOxqIFDneyYoq+VvVoyWazRqVcvsJ4vJXgLPZMcbITQIHjMgW1jLrdKhEa4JA8dDKBLdr7MvI0Lw28NXEs2ir3TZ+ZJOAQbRzITNn4eL5hWPZ+Yo3pjQ9Xpbp/yBsgQwftn1ZmKilHufC0U2RokyWisS0I3DdN0W1EcaqqVul0LGBeUTY8Npv7v9D4km+0pfohycotzHHguy4RQV/RnO/BH4kh6IVgYOzj/cqdoogQQCRZrfWGNvfAqnIBYWaMB0Y+WnMs/2QljYrXaC21jvAjmxPLFebyo8N0dcYdX6dtyF4reWDhFaXSf2RlI6SlmSUhKyG+c/3eAcM83tSZVeU/xrLZWaFgQd4TWwzsJoLKsBIr/qCacc/GAox6twgXZOC6597BMI1pszzSK0WxgLQMJjoUl7a85KpooI+7IElir57Y48iFahDMJgNXPveJs6rFi67b2A40Xm6R5ehRB5EvFDEeWLNDNAFHxz8AoZsqpP5oDOyxY2iWQxN/sFNFdHJU3dVZWrU8asJnfAlBwASotFDG3Oc68JDx3F/7GzhLFU+2MUM4qH/CVOIfsvERPFuy6z2iArprbYLKA5MEqruJEP+SHag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(2616005)(83380400001)(31696002)(86362001)(44832011)(36756003)(4744005)(41300700001)(31686004)(8676002)(8936002)(2906002)(5660300002)(316002)(66946007)(66476007)(66556008)(6486002)(478600001)(6666004)(38100700002)(53546011)(6506007)(6512007)(26005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG5wVXBjQjdQVkZWYmRoMUVDQnlLR3loV29ld0U1Yllxb21CZW5VT2hjUnFF?=
 =?utf-8?B?dmprY2F4STVqNnZjS2xyZE12a0V3K24xeUF2a1lSRjlnMGk4V2k3QUJ3S1hx?=
 =?utf-8?B?STFqZmFlTHh5Z2ErYzJvNTgvejI3bkxvRkltcWJ5RTlqbG1kdlp5SmtuMEFR?=
 =?utf-8?B?eE1PZDR5RGwxNkhLOU5XcTBRNDJ6L3YrdDdTSGRBL3FEMGQ0R3VyeXBsRnYy?=
 =?utf-8?B?WVhOK0xlQXVRNUEyZGZEM3lkblNpWjFGRUJvWU1LR0ZyV3E4RGNqeE5jbzJI?=
 =?utf-8?B?eVBVSzQyS09kSUREc2JpM2xFOEZaM1BlQlBmRFBCZkNsK1ZtN3VkbHNnM2Yy?=
 =?utf-8?B?VjRqdUNoTDJYRkExbUl6L2ttZkFlYUZnN2FtNWZPbUdxbVRnYUptUWVjYnZF?=
 =?utf-8?B?Mk10MjlqekNsd3Uwc2NxUCtkeTY0WkQzWkQzQTNTUVNWN0Q1R25tRncxL1Vn?=
 =?utf-8?B?cGpGWFZJS0JTekppaE9qNEhBd2VSN2FrQUVUUE1Mb0xubjlsaVM1ak93b0hM?=
 =?utf-8?B?eVY2ZzJzeFJWZzJDZHNTNWxHaktYSENtRGhMdE1vRGh0OEFyMitQdTZLcm81?=
 =?utf-8?B?eUx5dDFhejd1K2tOUUxVSm9TMlhVSGRlbTNKK1pJYUFoaENTd2RvRjlMOUN5?=
 =?utf-8?B?WndERFZNRmF6SjZyMHFQZEIyS3Z1dkJIS3A3YXphTGdlUGxkdGxMNXdUWXRo?=
 =?utf-8?B?ZlQ3VFdKaVZnaWZkVnFDY2xpUUFnRkRHWk5kUHBORUxuRWFhc2h1RWFoNXlB?=
 =?utf-8?B?TTUvVzZtY0pHa2I1TnhLTnpOWjc4R3NBYmNSQXpJU1IwcTVidlRUMitybzAw?=
 =?utf-8?B?bnBkNFBtSm1WVWRoNTFpcGg0MTVQWmZkMEI2dENnMnhrTUJkYXRUc0dSRjFy?=
 =?utf-8?B?WG80SHdRY3J1aGFkTWZDWnVCZHdaWDY0emRlUVNjckxqYXlpeHE1V1R5Y0Zi?=
 =?utf-8?B?bXVpYk9XdnpzaHZrNHJqZDZrRklEUjgwSE9VcFFyRWwvMXZtVzJlTExQWDZk?=
 =?utf-8?B?a3BVTjM2b3M3eWNZWjhweG5UL25JdlFhSjJoTEROTVpKUjZVK0dHWU5ubS8w?=
 =?utf-8?B?ejdYV1ZvbmVITDYvc0I5ZzF0cVJ5NmRFdXFVUm9oK2ovU0RLRW93d2ZIaTQ0?=
 =?utf-8?B?NkM3Z3k1TCs2eTlERW9EMVdIVGg5TWtERFlka0kxMnZyZXFOYUpXVXJjY1JS?=
 =?utf-8?B?eWdWRGlKSUh5ZzUwK09rRHkvczhpMTZiVU5OZEIxYmlIeXdRYnY2Q2U2Tndy?=
 =?utf-8?B?eGhqUFBqVDMwMlFUOEJUSHk0OTUydWYvVkVQSmhxR0g2UVJPZWJiTnJ6bW9k?=
 =?utf-8?B?cGR4OWV5TE5VVXRDaHJ5cFdRS2Z3V2oydm9zdFBWSlJZdVhVdnJyYXdJeXU1?=
 =?utf-8?B?N3VtaVZscHZtd1VVYnlrK2FmS0oxckNGMzNyZFZrTmZsNFhWTHgraCtLMGg3?=
 =?utf-8?B?S2RWejNlL1YvWEtmQjNaNTBGV3dPTHVFMmtOTHBIN0J6b0FyNnFpNC9tcHJs?=
 =?utf-8?B?U2xnY2tLUEE2NnJVM1RNTmhZL2hoZG8wZ2FqbXZZOVdMTHRFMkhKNUJSZVg3?=
 =?utf-8?B?OXR4L05TQjBIYVpkMXVVVXBYSm5UTDMrUWp2ZlIveFFONC9MSnJxd2lTL0hl?=
 =?utf-8?B?ajFpK3ZPd2dpR0pKVEwxT3FrakJ4bmNXT2pkUm5xV0RVTTFENy9UWlI5ZTZO?=
 =?utf-8?B?d0V2NGhROUlib1F2cUs3T21adnRmSjBJbXN2Y0x1eFlDem1SOXdkWE92YUpp?=
 =?utf-8?B?SVFiUWpnMTI1bHg5RkhPT2JPNW82YnErSDA5eXJMUzQvRnUrcjBwajZoS3lJ?=
 =?utf-8?B?b0Rkbk5TNVh4aWh1L3JEVTFZQk5Dc0JPVkEyV3dNSUIyc09qeFh4dUN6YUxx?=
 =?utf-8?B?NmNyaFBYa0hCZ1krQ1QyTVZvTGQ4TUZPUnNUeXlsQ1liUGtkY1c2NlNhL1Y0?=
 =?utf-8?B?M1c3czdrT1U1aThka3l2MHVaL2VkaStFb3ZHOE1DbU9hSlFiZ2d0Tmt6QmxX?=
 =?utf-8?B?L2RxNDVDcUdhNzl4a242U3BBUkp3WW44VTNZYU1SVTlYNnFFQ0V6eWVTU0sr?=
 =?utf-8?B?Z2JvS0Q2TXByUCtveHI2Z3A3cHI5ZlQrdnl3QUtBbWkySUNSTTNDQmZ2VGJS?=
 =?utf-8?Q?+H3mcN2JyaOdqT95RpdPL1BpN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Tjoizz/I8sxQ0QIaN0kTeKFpq4T8UeSYc6s4o6EuaOsrZtRsBOV7EUPSUU1dcLzneqjbXhcl5uixi/OwyoOuyPemS+ebxZ+HpHcBSKv99evI1CqgE2kbassSdWR+aeteVPsP4wuIh8Jdg4CgQ5WySVuwcKCkeIBplzcA2y14FZOm/Cu3fsqyVzgdpCwTt2HjXJ9PU3MGPH2qnr3qTyGJxKtpg+JjbJqEvGgu5Un8bwEzRivOdIhkgyT9uM8fk7aKEkUcPawcYW719Cg88F73BAYT4DFA1prOltx0BKGQkdnRERiU4TVrbh4/rnmVpW9hH7JlJJKVegpfFZf+UpLI14Jfna1IF+zB9flerdV8npEyEMJrKSIERQNyxH9/MjbBy2FwHnpKMDn1Ui1bsgmL6gCU6RpJZ6JcKzQlG3/JCRI3EkwHOLWorcvuWrM7cx0WYYY5RfFdZ3FpdsFMZW33ij2X33ciWwC3uMLVZ9WEN6PsotyD9cEMeVl7adabygSsoEO7StbJmx2jm9lcjQp9p3o6XCY3scJ0Rd42sunJ4hJWHC3KP04550/iaM6K282w68WUWfJ3QIOtDcpcr9umAc1JMA2zylVqWC0UeR7sEguXBMQKS3+NJu3GlmUYCi7cuuiOQ56x3rZ7XoMx5oNKZBpNJW2U7JQ00hjImzKdIMmVOCusJO5Yx2N8MkQutp9lzfaT5XDK3QH5nM3KPShIC5V77VRDFhTg59XtP2QkF+8fFm8NH7hsq5Ni4jtmX4KAjTsD9HuwhYuGbHca4bDPkIkfiGxbUmDvpAvsy71sE8A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20966dd-7dd6-47db-c340-08db7bbf4999
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 12:16:11.1296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/ApwA2tHTqiekW28fzfjFI/tDZ1aBA3vp/Vpv2wGMWq4jIvhZc9MUGtBVDrmm9dwnjJksACPIlvuHl2BnIolg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_09,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030110
X-Proofpoint-ORIG-GUID: Kc_su_zAuUVn5KYr0rwzMrRC6f7tMvZT
X-Proofpoint-GUID: Kc_su_zAuUVn5KYr0rwzMrRC6f7tMvZT
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/7/23 19:03, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At exclude_super_stripes(), if we happen to find a block group that has
> super blocks mapped to it and we are on a zoned filesystem, we error out
> as this is not supposed to happen, indicating either a bug or maybe some
> memory corruption for example. However we are exiting the function without
> freeing the memory allocated for the logical address of the super blocks.
> Fix this by freeing the logical address.
> 
> Fixes: 12659251ca5d ("btrfs: implement log-structured superblock for ZONED mode")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

