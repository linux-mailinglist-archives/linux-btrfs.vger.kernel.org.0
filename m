Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03D8583808
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jul 2022 06:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiG1EuV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 00:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiG1EuT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 00:50:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9583064D9
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 21:50:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RNOHgK020280;
        Thu, 28 Jul 2022 04:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xJ7PoEMGYpkk9lhBMXJlx8Hk+L/MnFdcrT6VYZIDJyA=;
 b=jxRtZzLs/sjxT7i+wzG1gCMgX0LJ6/MEKj5moCEnMNgCb4YKykS9J/pVcp3idC/XIS2l
 MDLjJUqjP1nrcf/vE9+DDBUBid3gflsuT5/umdwCW49NP7wiGsZT2y+sRRqyKzzYoSra
 QDxddb3Im84mn07R070CGGFnMy2tTAsxtoz4tkQQ1PS3hI9zej8W4MLlWdCRZ674OvTy
 k6Ae4ap5DLEGo7Q1IoQnMstocT1aYFC/ALL6S5Kr8LrDnH4Nd0Vg4xFqoz2HHIzFquK/
 w3eyGS3ZogYhO+pjW/dViJI/iy0cSkPomNuQVQiS99sRMGNBJthA74+6mmi5VEKlfuEV WQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsuubp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 04:50:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26S3vJaM023083;
        Thu, 28 Jul 2022 04:50:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh5yx2dy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 04:50:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WF243keRwgAZXdkZuKmnzKTekxt/nZzOba8oxbzgjicqzq89LZ8PJoWIyCTCtwT9IeLKcdK/PskuRvaf4hTzdo3/ywc8yOoHAW0pYJmAM3qtKRJVemXn8fpQ6Ymz72iJ8k6oA4ngJJEARByv2MAR9r3pfA8hfXwyb/lhP6AJ5qArpkDDKkA23h9wRindkE1Ryf9rMY7v/L9qJAAlM9Kmrb8QRWOmAGo8GmA+K/D6yFMY2cwai72bn4w3rTL2lC5J4i3UyTuHI5VFuvbETPtbKk7UkL/DkyPbCMfhyPxM2cGan/gZK2TCCHs/KkM4gEBTUlUkXL6QNYvzAHdt7EjdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJ7PoEMGYpkk9lhBMXJlx8Hk+L/MnFdcrT6VYZIDJyA=;
 b=PY58nprSLYoGq+Aw+jNrNU6hvc+2kp/3bCNPRj7LmzPfMCJc71rVgvxQJJm4lK/+TSpzE/odKXbcAazeSCztRI7lsRZmKa+m94032bGErfrTHx1LRtL+RQbRnZ7tn26h7ChrlYE28C9HcN2e4kKAWrLvsalOK29n5WIYASODrWmv+JQ+ISeYhzQgbmvnsM2C+ewvsl43wgMc9BB4KtO37cXg7PGkixodUuZPeQxcDbZNvs1p9eKu5c7qBR3+riTFfWrCmC8WdKNWc2VVhTBweBZdwBeK7AELJSa9OpxZewzpBa10+Rpd5uq7q7KmFK42DunrGASpgx+l9OcjkSplKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ7PoEMGYpkk9lhBMXJlx8Hk+L/MnFdcrT6VYZIDJyA=;
 b=w1580lphnu6dHP9LKyHpWHW2byxS56Nr9/TuFmKODLM9Rt7XmXRKkr/C4i3I/f1xuKWWQsA5iSPMHKtKh/63hAaBlx7LI+paeCD7yAxWDkn2Qe+STVz7fNW+c7zAWorcCTMJxoQdpLDHIzxb4RX8DuyL9Prh0s/x492zsVZwTag=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB2684.namprd10.prod.outlook.com (2603:10b6:5:ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 28 Jul
 2022 04:50:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 04:50:10 +0000
Message-ID: <f4321664-18cd-1153-4380-d5a9bff64111@oracle.com>
Date:   Thu, 28 Jul 2022 12:50:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: sysfs: show discard stats and tunables in
 non-debug build
To:     David Sterba <dsterba@suse.com>
References: <20220727175659.16661-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20220727175659.16661-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30f734dc-edca-4197-6f44-08da7054a692
X-MS-TrafficTypeDiagnostic: DM6PR10MB2684:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AJ8ICYTMjezvw50u+Ev7pGcNb6C+Eyqv7WTFWi0GlHxmJqVw6FuZriFV6HtAweaW2KSrQoI/CcadCpruqD2omlVzbri4AHpd+F3RiibA7lGMOo98WJIBDep0nNh4voK3iisTmZW2ETZ7OAxQopjD+sYq38wTwF3aD/URxtLy3cTUyBp4ob2YVuMxstaAJ8kJvCnphnfD2nAQ6Adt7kfFoHmZ4gILQBCN2uI51P3FLvU7WsB9PYaIcBhU32Qh2/NMk6nuNwL3Oe0CFu+ro9799sDaOJnSte1bCw1nDWKqn+p9h4deptHkZ9Me6fjnHOcdb7gqasQ3qWRmkUSedWsJMDZjosFZ5smHRiRiQ8Yjr/Vl4oEtSl96ZIa+UixmSvY1hsl76oSId851zdGvgmkX+GgkKCApXRsfXhYbw2DDWvQDAu9Rp2vZysHOg+uLh8q2JGSCcDyShbIwN41wORDSxSCo+AXXVVf3hKyWExwzY6Qwv10Nahbm5IP8m3jRllA/OhV6A06hQ30EWW3dbep09gErnE793Zm1iRyIjqFvwvREJBV105kt+CyfgimsLbFlISHIneAnOz2UmS+CEEx2NPwKH9zFiNZeki703MRpcNCB7GuWjrBc7F5fXmvthkCEdeZFnct76kvAGIJyhTtROvLBoE11efIev4OHnNku8eee7DyyrtxeMGmv5JkXVbzE4bF9JJRkXpBXhvkIcG+vqi0uEHQk1Vm4uBtNVFxrjHq9oWATPXqhJFiqBs5edwFHa0S8IPsDnKCs2mzE1T5b5Zg0+wt33verM/ihG1QbL7SKy2lJCGc1ulaSGOTtQQrn3rVkUAdGNUFLT2VsySyTxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(136003)(396003)(376002)(6916009)(4326008)(26005)(6512007)(8676002)(6666004)(44832011)(66556008)(66476007)(66946007)(6506007)(86362001)(186003)(8936002)(83380400001)(2616005)(316002)(478600001)(41300700001)(31696002)(5660300002)(2906002)(31686004)(36756003)(38100700002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REhMZUp1UlRhSmFMRXREdk5SaXQxUDIzMm9sTXZOUzhlQ0hJdlVZa09RbmxT?=
 =?utf-8?B?SG1QTGFFeExCaTlKWmQ3d0ZwZzhtZVRlU2wwdDNFdVp2bjY4NGFRZnFxV29M?=
 =?utf-8?B?L1NzdDlyeG1xU1I3Q3dyak4rV3Y5OW9LRjNPNVM4ZzhUM3dtN1crRDFSdm01?=
 =?utf-8?B?cklmbDJKTnV0SU9SQWpTTHdrMUMzTXFaOTJ0RnhETVRpMlB2VnJaMTRpcCsz?=
 =?utf-8?B?T3J0WTdRYXJZN0ozMDRLMDVLcXMrZ3d6bU9Zdk1vUUxGUi9yUzFrUmZWRnFs?=
 =?utf-8?B?MFVFSGxxc0hVVzA3ckV6eTE4d0dCN0xaTnFUaEE4MThFc3ZtakZRaW0wOFNp?=
 =?utf-8?B?eGh0M0V2TFByYVhxNERSNzRrWHErMjJvMW1ncHRUaGcwL2t3QVo3Y2VScWlr?=
 =?utf-8?B?VHN5d0dkUFE4bitRTWgzdDlrVHc4aTVwOEI1VXJQVzZJdWw5ZVkyWWFYTy9B?=
 =?utf-8?B?eHozN2ZVanJlM0p1VjN1NUp1US9ZZUl2bUdWMXpVU1c1Tk9FRGEwdFlBY050?=
 =?utf-8?B?UklQYmhBcWZKdDdDTnE1Y2NrWitwZE5NcllGQnRySWNBWGtEd3Naem5ucExO?=
 =?utf-8?B?ek5mZ1I4RFdKWmMzc2ZwM2dJVzEyRnhjYTQ1OXIzTndVTElaY29PeWJwcU1m?=
 =?utf-8?B?VE80MXkzQU9nZFArVVhEYk9XK25xYU11N2FlUENqUDNDV0szUlpRbHoyZEUz?=
 =?utf-8?B?YzJqTGUxL21BdDYwUGZDOFNZdXpucnoyai9UY1g2cWlLSzQxcGxINjVhcnN1?=
 =?utf-8?B?dnZQak43WDczbDRuVHNScklXUGlXWC9VZ1QxUXJwR1IrK013RmNuUVlIOGdu?=
 =?utf-8?B?YXJIajhZcVVnaGZNdDVWK3cvdXl6Z3VOUzROcnRicmhhNm1ES1RveWl2NFZu?=
 =?utf-8?B?SkdrMlBlLzFYWjN3NjdkdXZxUERQaFRSZ2IvaWdrUjRxKzEycjJ5ZitPQjQ4?=
 =?utf-8?B?WE1yajM5N2oyMDlJdFJ0L1dEWkMyam1vNnUzMEM3Mk11N2hNaCtQbWZtZXhl?=
 =?utf-8?B?YzV0QVNuWVN3WGQrYkx0N3RzaFFGUlZjNkJYaEtna2ZwUkZoSSt1bERwN2dx?=
 =?utf-8?B?elNnNnFDQ0x5QStqTE1odUgvYnpXVStvc3BHajJnblAvVllrbTlhdE4vc2pm?=
 =?utf-8?B?UUU4WGpNemJMNTYySjI1M05rL214RFAyWnpHN0ZpcFlld1VGNkg2VXhxVTht?=
 =?utf-8?B?N2xqNm5lZ29WOEdtanFmbml1c1lzY3BzR3JDTkhsYTdxaTU5V3BDaWJ4enQr?=
 =?utf-8?B?OHoxV3VRdmdUU3REQ0lHZ2hKWk0zWG9FUmdPYXJQSjMxNjhUNVphVmluek8x?=
 =?utf-8?B?a2E2ek5uTDZsOFlJMHVOUDJQd01CM3dyRE03ZUl2ZmVLVm12My9rWWxHM2dY?=
 =?utf-8?B?V1pVUDBIa2VYU0lWbEdNQUNqbGZRUnM1V1J0ZldSVmRPSS93eEozcVNoVzJD?=
 =?utf-8?B?NVZobTdUTnR6YW84RmZjOWlkQTdGZFU0MGxWZ3o0ZUFIdFVCZGIvYWJPcVhk?=
 =?utf-8?B?SkFiN05WMlhYK2dSamsvbnpnOU41bkRlQXp3NWxZWlBvL1EzMlFvaWF3WENi?=
 =?utf-8?B?UXpnMk1hdzdFM3lsZHF5Z3pOSmc5aE80NUIwTEIzQ01INjduV2lCN04xUDJl?=
 =?utf-8?B?bWdPMGlnR0UzUU9tbHl5R1dmbEg1bk1ENll3cnlkZGY2VzNPWDB0MUVFeXRK?=
 =?utf-8?B?Ky9UWVRUd2I0ZC9Wc3lVM2M3bHBjbi9aaHc1akNvQWh0WDNmdXVDbE5JYlYv?=
 =?utf-8?B?NkhHTTV2M2s4aWt6aFpjSnVOVDhHbktZaitmYmJ5SW1HNGpLVU5FbE9idWpN?=
 =?utf-8?B?ZDk5WmwxcStzeHFTOUROdDBxNHJrNHljSit6Q1g4WVVCUzJ4NHhhbWh4M2ta?=
 =?utf-8?B?NmlRbm4zeVF3bWdWQVBFQytPR1U2VlY4bHFZR01yNFk5UElpb3EwNVlEN09h?=
 =?utf-8?B?V24yK1ZyMzFvZTljUTd5dDdSeEFidjc0QnV5T2x1RnFhYk1jZ2FGTXkwZldo?=
 =?utf-8?B?cXhHdmVUQ2JUaDBlWTZ5Z2t3SDc2eS9RM0lhdzFGNFVqOURLMjVEVGw2M1Bw?=
 =?utf-8?B?dDJXQkVJQkFsdkJKQjhzcnpHR0JGMEZSVHo1WSt1c1NFby9IM2crZVhZaEd4?=
 =?utf-8?Q?enWFBQtp6/oOX3lrRTGSVh20T?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f734dc-edca-4197-6f44-08da7054a692
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 04:50:10.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXyU6Api0Ehl7ZZu5ehBhqPEOQ6OIjgQqLvE9dx6vWGnkvQ7v5fcUZWMTIAR7lNjUd7WaETS7XcKTg5WdcFgiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280020
X-Proofpoint-ORIG-GUID: 0btrUUq3iteqKdxzF6h3hOMDDt5FiUSE
X-Proofpoint-GUID: 0btrUUq3iteqKdxzF6h3hOMDDt5FiUSE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org





> @@ -1102,7 +1103,6 @@ struct btrfs_fs_info {
>   
>   #ifdef CONFIG_BTRFS_DEBUG
>   	struct kobject *debug_kobj;

debug_kobj is defined inside the CONFIG_BTRFS_DEBUG;;

> -	struct kobject *discard_debug_kobj;
>   	struct list_head allocated_roots;
>   
>   	spinlock_t eb_leak_lock;


> -#ifdef CONFIG_BTRFS_DEBUG
> -	if (fs_info->discard_debug_kobj) {
> -		sysfs_remove_files(fs_info->discard_debug_kobj,
> -				   discard_debug_attrs);
> -		kobject_del(fs_info->discard_debug_kobj);
> -		kobject_put(fs_info->discard_debug_kobj);
> +	if (fs_info->discard_kobj) {
> +		sysfs_remove_files(fs_info->discard_kobj, discard_attrs);
> +		kobject_del(fs_info->discard_kobj);
> +		kobject_put(fs_info->discard_kobj);
>   	} >   	if (fs_info->debug_kobj) {

but here it got accessed outside of CONFIG_BTRFS_DEBUG define.

>   		sysfs_remove_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
>   		kobject_del(fs_info->debug_kobj);
>   		kobject_put(fs_info->debug_kobj);
>   	}
> -#endif
> +


I wonder if compile will fail? or if diff showing it wrongly?
Sorry I didn't try compile the patch without CONFIG_BTRFS_DEBUG defined.


