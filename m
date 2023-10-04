Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE57B8322
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 17:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243038AbjJDPBu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 11:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjJDPBt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 11:01:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D27AB
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 08:01:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948ivcv011621;
        Wed, 4 Oct 2023 15:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Sm39d6HmetxGzA5+JmCCFzhOyzXzVIQOGaLPOrrg534=;
 b=1vScH0yQwjy2Vq3a2aR8xPBxKoYDbNTDlZakwH7Ja6r2ulwPKVahqjf2a0/cI/JlJ5lT
 JsIh3ARcbCgXta2+vv0c0o1cCaXjR6rb1QF2xzdYnFp1cRXD9KMfa3plERaDGlkx+VWF
 E39SKI8TwSYYDR9mauJl+lhmh5DIx1RzjpHVlnaCM9wLNwDq9cSiDVFZV8syeJmwqhqn
 OfwDQHg3PZxk9WYPZ0sni4YSlA1UgazIcGXvMKfGNz4UTon8UrNR9WH2IkPDftmVhVlf
 T/UnWAkp8bubGsJkneS7OKxt+yGcKi4BU7LAqLIqqFhQXGGRmTqBb/Ftb0WbKT5lLCTw +w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vf7s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 15:01:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394El9VA002983;
        Wed, 4 Oct 2023 15:01:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47p6tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 15:01:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQp7ySEXnQjtstEdOOI97rMJufk4hnEeMlLi+bKH0kwzqkWfjFztWx3iESb+6j4uyt/RqJXix4qe6eDuLVojI56OoE0GYI1ZxaIzudj/I1dQsi0kT/qF4oGr+DScTtn+SkFa0UT+548R8090ppmRmC/yyfmAh7zHhynbTQXCnTwfjThPpRlax6gIlQ7nOzlEz7yaD0coyf03WKmr+EKlTzg/P7rNK9YZxjGgDgBWqm+RMRidwDzNYgwJXPcIUInLJI/TKrsyB5s1vExNMLKylHBC6BRoH3s9J+lxAyYBP09uX9RvmbQIxRObcqqTQ/f+MGSYr/1bxQoJeYhcUlwv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sm39d6HmetxGzA5+JmCCFzhOyzXzVIQOGaLPOrrg534=;
 b=kaMdJz5uZr2Z1BEw992TLh2qO3+WLTWt1MNlzUqETBQqwnKvVUMMCkfDPe4JZLBDVL/Vuxvx1llx1KzENN1azbnJHtEmUPvze+gRQZ/oMdX0lL6BPsFgW46u19Mp1/deRJOJLaNbdP7I/o4HcM1CUSDHWxdIXo1t5aG5BLSBKjES2XjnH33CZiUmTwXrcaKxVPP0ZVH8eP9jH+ZI+30m1AsQOhi91wu7Cv0bc9uxdRk7lenpZ+b5vz5aPpsl/lNC5jmTU75jP16dMuBAEtkxOu9jeZFZ+tnSzY0JSU3eo6D+dEI4vbHdjUlmFHZP8WjKscqr0OjrrEZUeDQUPKNjYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sm39d6HmetxGzA5+JmCCFzhOyzXzVIQOGaLPOrrg534=;
 b=Qg3dNqo5f5V6Rb8rXz6RxzgfdGRa7nZihN5VZ4Lsj4zboepvO6ZiorLYypNU7dVbU15rwrSZWuJjnD0yTZBoaycDUtHRDoX+HrA7ptqBGZKLKJCpmGxA/y1zQ62paFD4Mp3PooeKv9bXE7OIPog38GPTGKMIFIQb0Fj+p+09B2Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6872.namprd10.prod.outlook.com (2603:10b6:8:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 4 Oct
 2023 15:01:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 15:01:03 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.com,
        gpiccoli@igalia.com
Subject: [PATCH 4/4] btrfs: show temp_fsid feature in sysfs
Date:   Wed,  4 Oct 2023 23:00:27 +0800
Message-Id: <9fca0011d2ac24f7b84990db1c4af5eaa60da876.1696431315.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1696431315.git.anand.jain@oracle.com>
References: <cover.1696431315.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: b66ef8b0-b2a9-4a9f-294b-08dbc4eaba82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngLgl2mnaWjkCP5sOaDlLDoNRYR4fD0yZF43jwMP5ABYo4ej8pquBOC9m89jiqL0MhYsHGDTQOv0bj9QbGogN5YFKXss/kvNKn2RougCjZTJ6xvF3xeJm7H4yjwY/2x2kGGTSMSs9aTWgVIB1zglIp34AU9PPaNTEG8CKbZ3U6HUmpIkxSwEBTsop2E/2iOctIrHyag6GIlrU8RzV/u5EhIkwCP2UuE5OX5kPISS5WtZWCn8OWdQGenE0ELo4QoWlw9i8+XDJKE3mcyrmkqVqIoWYQDX6vp5Ojbfa4Lf2qm8xUNZwFlJklFTLqOBN0ablV2ZsVeZyZ3ESVbcFNykR2WhsToLerwTRQR7WnHY7CDyGyfxQJQczuWvFh+o22CGmsbFNfJqdEO09XMME325xiog35jkXlKvZpfy1ZpZIYZiv2YsWVYmX3RD3IXbm9umYgHvhJDGzP7jmzR8MHwgbdT7jvSTgK7UPGCurmE7El8wPo9kUe62Fxg0YrAtSXp3cBM486q60touesZQLrGLSSpY3fhc/PNGn8aE2BPqNNP4WyrZQ0CeCqiMyrnXCrdB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(316002)(66476007)(66556008)(66946007)(6916009)(2616005)(8676002)(26005)(8936002)(41300700001)(36756003)(478600001)(86362001)(6506007)(6486002)(6666004)(38100700002)(6512007)(4326008)(2906002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gry5rYYW9hhDRrOrWmZL2+aSDV5yim2DUYwgTJ6aiQs1VYkqTs8wyKMMjMeC?=
 =?us-ascii?Q?ijyTiCDz86fxUUNWaT7KvozUn/jBELEpPucuZy8ZkxfbyUvYDa6en73imjLz?=
 =?us-ascii?Q?65cdpuntsoZcQeTgggfucTh2CUUbY5qh8Dowdyqb7A95xPlXqnwPYt3JFEA5?=
 =?us-ascii?Q?D+JtBLQiP/QkOpGv0AKQXi6g0/fYPY8Z59d2qU12EOX2MwDw6ZCyyaIWUGuG?=
 =?us-ascii?Q?5eco/pmwAHR9FhywqIEOv5NnnGAxP87JzEBkgM/L7BK9cFF7YBS9Elt/jh4E?=
 =?us-ascii?Q?Cy4h4ETtGBvTIjDlWyJsKhUEVCa/jmbA/5cx8JZVLgNsgNRbODO4PaCk0QZ2?=
 =?us-ascii?Q?TI2qrHJfFyZihKf1FjPczrhwTeu4ErCluGL0y5wXISIdZtkhDcX21mSePQft?=
 =?us-ascii?Q?O2xj5ZpGVtFoZ3RZWCPrk+N7IYHq3uqYlXWyvWb70/vp8tcAxJ1kAi12/Squ?=
 =?us-ascii?Q?Vy3gc5rHIof1g3uZlTTs465qegD21flrD2Mfq/ORWsUqx96yGZ/qXrXfW6fT?=
 =?us-ascii?Q?bsdcszOqWLfEw80NaYqeqsUXUxJovHG1wtXb6MP5nnwLniDJplY3p79GJrh7?=
 =?us-ascii?Q?QRR/2g7rv/gT9erRl+Ga83LTmwmQHh8fQY+aoJBjgaooOdZ5yMN+wKSe2Ovs?=
 =?us-ascii?Q?N0WAYhgtw7B1maGo/kttgVePwhMo9nj0HoNhnzEbOjcgI8HIjLl7AxVa3DmQ?=
 =?us-ascii?Q?dZDV1pUfwZi6LhtIgrkD86+RSEsdI5K/y9tlUu2rIDo6WUAEMykQRYXmLAUP?=
 =?us-ascii?Q?mz2hZpNw1Qba9BLuL9QKj4VtcfdTIQ1mT/qt7xuS3NofyB9eP0kzMMgRhHA/?=
 =?us-ascii?Q?wjRxDsaj6ROCCQMlGvD3q1b9ebTRzcrWC66nYr8ehH67hVam2CPVp0l6fCyV?=
 =?us-ascii?Q?ckwOCm7J0dvQAErkhr0ftiQG+LbYN2z8hHI2ggEFDWl8VnhZovZ7LtkZJkbK?=
 =?us-ascii?Q?XsBo2PjmBXkZQ2lu5M0CN15oFQaYHRylW0Lgngv1462ZfulDVCaxtuUA13dr?=
 =?us-ascii?Q?cUqaA0x1oPBTo+VF4it9UkrbnqJqqpX+NvFYpw49lnaA67KtPba3pMNrPmvQ?=
 =?us-ascii?Q?0ChtschS5bAsgEQfBrA1P7fLVCgB1wZ/c2r+VfTx8F76XdMOHE6tFkd9T/w6?=
 =?us-ascii?Q?lBXB3bwINyelokCqtpgje384kbf1BOVw81EsSUU4Q6NHtHHfvQ4KCx2ZKf9T?=
 =?us-ascii?Q?oKCPY1xi57rh1firWWgukdggB05BKGcqKBrCses58LDVuir4O1UkFDdYlT2s?=
 =?us-ascii?Q?WLORtODxyVmZxL8HO2Qg9E1vYOAoyI3adfL5lpalg2rTTjARqpIgJlpmu+PM?=
 =?us-ascii?Q?K2AxJ+9XhujO8cCa2+xx8QO6uJPie85FVOBdy/U+Kq1L3rwUPDg0/C9uHslb?=
 =?us-ascii?Q?qfGQT2mhZOg1c+grQ6MN8lAgXW/PmZU+ziXJg/BmYuPSIcANqoMxWRMtKOIH?=
 =?us-ascii?Q?aBJIe2Vb9oJIhg6v/0Mfmc5VB4SFhpejU5kn2h0mXAS/98lCy7RMAKBGI7qF?=
 =?us-ascii?Q?nQH8fa1a+Cqs1kTx+4rZ4SghoS9tPO4L4rTfEMolGFljXvXz8/RNTWtik4DQ?=
 =?us-ascii?Q?bTFC/adpdydSEIWuwZ23vZs9LM71uBMMFQ2e5reTZmj8B5+6PA9vGlnKU+ZK?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 92T6nJP5Ud+j4fFmChvFeXaM6RbwRaY9/vpoiB/8LXmfHjcnLmwPwIiv6Odg01wPjM6j90B7zZOOk0PBLpW19UfsnTUub8fZY20UwxuYRnvG8Z40+4rKPfqhI4HM7h2r6Fp77dJZoatG8pi98c8aNY/NsoYwjIBQ+yBM7VLT/Gx7AR7n93i5SUpYyMGoVWLTz0n5gFFiO5jHHUC777wzxvKoDci8kVZ1Symk76JaXiNKLfEzluRGrMscM5X1bEYeVitVGBZI+UvFPfflN6qab5cDryRdIfPNx4sxVtP0GACoUZV5NCTXGoyYpF3ABGYZX9sY+Qpbm+XCoenP2hAZ9+6sl4PL6m9W274+PALpqSezgItn8Z49XhPyuXADOctwwPB2Le6JFXO65ix5ERv5lK/Ga3Kp1bmC6ZDt4vt/SQ21kSaf18PYh5JbR9vZ3nAcIQBoiMryQi715FpM9gqOHSXUpFdzPI/j6nre/RcvVj7U2SX6rb7+WwCt/21oCrSqcAUPxyZFHMEBcFSDHY5OvuVPjlqb46YX9X6pBPBp02bqGEm4F/Dq0ZvlkmXZijsu/k9roxZk9qLQ13muIhZ3jsVAm0lE58WP5U/PdIQpBIMvT4/e6mfM+ZipmQpwVEpZsKGMHD/d5A4zYNMLSYXFzcEAVMkcz2hlE2KRIUvh+CHwDLFd3XTgvfiXl8Vazl2gWj0VaY7MfbnlSXVO1mA7RTmpRfSK5td22sK4fxkRk+ZMMVuT6+o1LYbbxuhNowwVkUdoRCM5p9yvY2KWj8GFn4Z12AE5V7Fen6mKK2X7GANHZMaRItDWAM7dT9ovQyPN
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66ef8b0-b2a9-4a9f-294b-08dbc4eaba82
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 15:01:03.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSYSckAXQtyVFL5urhKkfWuSvnZgNFS2YVdcGjTEtS6Lsm8yEXVnn+50R2P2mhpH5erWQLP43lPrH08J+BVc3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040108
X-Proofpoint-ORIG-GUID: wDCmOspxa8CtiNRNiVUSSBOc0OW80Ela
X-Proofpoint-GUID: wDCmOspxa8CtiNRNiVUSSBOc0OW80Ela
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This adds sysfs objects to indicate temp_fsid feature support and
its status.

  /sys/fs/btrfs/features/temp_fsid
  /sys/fs/btrfs/<UUID>/temp_fsid

  For example:

     Consider two cloned and mounted devices.

	$ blkid /dev/sdc[1-2]
	/dev/sdc1: UUID="509ad44b-ad2a-4a8a-bc8d-fe69db7220d5" ..
	/dev/sdc2: UUID="509ad44b-ad2a-4a8a-bc8d-fe69db7220d5" ..

     One gets actual fsid, and the other gets the temp_fsid when
     mounted.

	$ btrfs filesystem show -m
	Label: none  uuid: 509ad44b-ad2a-4a8a-bc8d-fe69db7220d5
		Total devices 1 FS bytes used 54.14MiB
		devid    1 size 300.00MiB used 144.00MiB path /dev/sdc1

	Label: none  uuid: 33bad74e-c91b-43a5-aef8-b3cab97ae63a
		Total devices 1 FS bytes used 54.14MiB
		devid    1 size 300.00MiB used 144.00MiB path /dev/sdc2

     Their sysfs as below.

	$ cat /sys/fs/btrfs/features/temp_fsid
	0

	$ cat /sys/fs/btrfs/509ad44b-ad2a-4a8a-bc8d-fe69db7220d5/temp_fsid
	0

	$ cat /sys/fs/btrfs/33bad74e-c91b-43a5-aef8-b3cab97ae63a/temp_fsid
	1

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e07be193323a..7f9a4790e013 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -425,6 +425,15 @@ static ssize_t acl_show(struct kobject *kobj, struct kobj_attribute *a, char *bu
 }
 BTRFS_ATTR(static_feature, acl, acl_show);
 
+static ssize_t temp_fsid_supported_show(struct kobject *kobj,
+					struct kobj_attribute *a, char *buf)
+{
+	int ret = 0;
+
+	return sysfs_emit(buf, "%d\n", ret);
+}
+BTRFS_ATTR(static_feature, temp_fsid, temp_fsid_supported_show);
+
 /*
  * Features which only depend on kernel version.
  *
@@ -438,6 +447,7 @@ static struct attribute *btrfs_supported_static_feature_attrs[] = {
 	BTRFS_ATTR_PTR(static_feature, send_stream_version),
 	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
 	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),
+	BTRFS_ATTR_PTR(static_feature, temp_fsid),
 	NULL
 };
 
@@ -1205,6 +1215,15 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
 }
 BTRFS_ATTR(, generation, btrfs_generation_show);
 
+static ssize_t btrfs_temp_fsid_show(struct kobject *kobj,
+				    struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+
+	return sysfs_emit(buf, "%d\n", fs_info->fs_devices->temp_fsid);
+}
+BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
+
 static const char * const btrfs_read_policy_name[] = { "pid" };
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
@@ -1307,6 +1326,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, read_policy),
 	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(, commit_stats),
+	BTRFS_ATTR_PTR(, temp_fsid),
 	NULL,
 };
 
-- 
2.38.1

