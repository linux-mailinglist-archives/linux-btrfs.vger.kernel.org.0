Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFE167437F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 21:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjASU1T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 15:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjASU1Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 15:27:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175847E685
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 12:27:14 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JGwsO8013434;
        Thu, 19 Jan 2023 20:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=F0AccYw+9BGZCzmKNkEYq46G/QMVxcf8r5FIUuTCUtg=;
 b=kfxFUXzwLwkxQ1zB7lzsIURaX4RYIlLl9PbxwESQjSBB/O38sPrwOJOnr14UpkDHKYXH
 JRAYpBtzVWp2WV3yz/sv7gAHxMSmyMS2B1BKuxXRFRX85Zn0KzYZ7hVp0TauIclCVAXm
 ztVady0a+llvBnuEkKMm1fyB4j094UewVeaGHAzow8F1vd/L5j1JYaGEsItpPd9py0H0
 8+EjPD4/TpLqxDrVUdcp83p5RFDZ+abf32xFxHkLO9SSbyWyYtcicmONME2tgqSVuQAH
 TFkvcZ2lo3/OOs4CFy0hwG6l784GLs9C0u/GkHVeZtWvRc2XHuS9nfLIXF8j3m4/iiOc jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaak6gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 20:26:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JJP2v5004637;
        Thu, 19 Jan 2023 20:26:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2ux794-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 20:26:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLsepQF7k2xVUnsLjcf/qT5SiyTCKmYl0VYFKvdUnjYgr0yohPzvhjwJDD6v3z0EAea228dsBV7UXaB5+Rq35ynk8KZMUoNZ24JqHK3P6iohDjRpOZG4JYve1fu8luMUL+fOca65kpyHAdvlYH9yjk8ZYtkVb71zRb9brIU2vxJzRO/GZ52qRgqKndzeND/VE9RWxHt6oHZ1QzNG7ZNrMr6+pavCnXgpICx5TFsnfX3r0xaXmCEUW8AESx0wwSGSOBAmPE/BoXn4HGc6EvyuOEC3Ctoapj5bMIRehqmHPZ7Mo9CPVkkWfB6GyguCEArf4Ifime4soiXCw3vGvYJ+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0AccYw+9BGZCzmKNkEYq46G/QMVxcf8r5FIUuTCUtg=;
 b=OXPICc/VEvP6LufxcZxvLeuUB9qPm3iBK4INLdQapIYky7LoiuMkJeyBkn1WwQDwr2L+f4AuH1YTs0z5tYO+6ZSHlRTfVXt2kHps/mTFAH6yriWeks4tH9j8I2ZVd09/OoxkrkZi23+uVVncrphJLHtb7Iif8meFXfxgNXMBmY6WIygPvJB13XnEqaahoMA18O1dSJ451BODKvPVunN/+2bJr4pvRJuORkHQ4b7mJnwUMTmuCFrY1KH2ukJHkpXpgFBEFxg4yqpw3clh2BETP+R6RClRJhxBC6tkWxN7x6if2qR3HqIAxi9PceQNYbJtJG6Lk0epupXhnplHca8MFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0AccYw+9BGZCzmKNkEYq46G/QMVxcf8r5FIUuTCUtg=;
 b=lhmK4924aZfnZG4zpGDZnewzMOawxbbewRPEnTC4/WYj5dcce2X4JAhGljWlVbTY3W4IwWsRhVnY/+yhS5mBxPCNwnkKNNib4TgrsC0iOKnCIIk6BF2mc5SkifgeEVjUibiG5Umc5gZLpYtZSJdeQTvWZOFPqPn9PhPdrVrGW/k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4409.namprd10.prod.outlook.com (2603:10b6:806:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.6; Thu, 19 Jan
 2023 20:26:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Thu, 19 Jan 2023
 20:26:55 +0000
Date:   Thu, 19 Jan 2023 15:26:53 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: new lockdep warning about registering a non-static key
Message-ID: <20230119202653.ph7bqtvvycqnu2wl@revolver>
References: <20230119151929.GA29005@lst.de>
 <20230119161530.GA767320@falcondesktop>
 <20230119185124.znt5j3zamcopntzz@revolver>
 <CAL3q7H4sDqL+zD66CJ2Ehh4CtcdUbaidN2RcSi7u+yjHKyrY=A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4sDqL+zD66CJ2Ehh4CtcdUbaidN2RcSi7u+yjHKyrY=A@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::32) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA2PR10MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f2176d-e409-4d54-e059-08dafa5b81ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqHk185hKr38edm8RYXr42zaeXA5y7FHqIx0iMGJPVl2SoXozU2cSb8wfsNzOPYP5L9HkwCxagwwLscV9C4ubPXLTY2ol7xpM4tiE7B+b8fWoCdgyrlPC3Tc02pAaENPfsgW25qMYKaogJPRQGtI+NtleEBv+XQ6JQuw2bQyMAyPo5+1HGR5efTVyateXYM3XLM8ceAyWb1b4QTXp7yhKYIrJTAaACF8FxwAEMC5esuLcYRoiQsh0u2qjBpacthKJOe+fcgebcg7+aYnmWKz6AkOy8Y2bFRSUynC4CQJ25EhLnqnr8CGE50qo73EYvmYT8HZ2ICgz/0mV9UHODklFmkiw9kab1fJ68QzE0T5nUQM7mSyqkKrc9Ax6Mq/dKuCBkaBbtDHbt/IrnP1OjArUQr9+jKNZkznj+pRGMenawbcan9vsKmEh+rql1u5h5gImftKa/elKR5UFZeBshUb3kBvbL9UF7KAsvcbEuABgpal+4IJvWAOQ8RVnFP4jXjRrbcc6Y+9EU2jr4CLDknYoWQrr3Y2yczG/V+iqG/BMpMZJGmYGNXUkJZz5GaUjsDen/bK6c0RZZu7FAmWeMHexwO2ccMLNn4W0VwPhjlwcKydwufE3O2sgeuYMYPLz6hHk8BgK9iXfJAewofBT5xGJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199015)(54906003)(316002)(1076003)(4326008)(5660300002)(8936002)(38100700002)(6916009)(41300700001)(8676002)(9686003)(26005)(6512007)(186003)(66556008)(83380400001)(66476007)(66946007)(33716001)(2906002)(86362001)(6486002)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vf6XpVygDB5hoCfjK2WkaExIOjeuUFpI/iEIVbCOVrL2vFWoxndO1xYSyR2h?=
 =?us-ascii?Q?V+7ly0lnaANE2pWBvK/dpGprc6wMqBEiin6lpT3roT1EuaGXGWtSGFLRhodH?=
 =?us-ascii?Q?f6Fhm6qdYcB34j6AjOWtA5RogQXDZCbrxHVy4Cn2M++UZJvV2NHFjOGCsuuh?=
 =?us-ascii?Q?RbclOYnmNlk3uUbwmi4YNRj7Ay4eF3iOGPeLZLJEsTgqyLhMcw6CEULZnPBP?=
 =?us-ascii?Q?BEdA1W/hIO7DUfpQqY2b8RdN2asfd53PCBsuXrfXOuuthR9BYf6dlUJJCtWC?=
 =?us-ascii?Q?KOsCJo/8Z1rWSMp/TslRGEfP/oTpCEn3KFjkAShIpOT9yckKtiojW3daVwCD?=
 =?us-ascii?Q?iGc/MDG+fURC73E9NrTAgd/D8pjikZ9NrjgkwL13IApK+GDfg31HguEY7I4W?=
 =?us-ascii?Q?bPHOPstFoHmbWskqoaC9Qe1pnotPo8eVqq5ZSHihT0vMYVN74+uMm1GfQMLb?=
 =?us-ascii?Q?wBV5QEf0z2yx11ESCFn7DQSpxhxnCNYqGyLV3YNhBS3z/6K7VVBWXSLHXkHY?=
 =?us-ascii?Q?DRLdDDfg9/c7krs1Pv5ly96LroRZVEsKMKu9BLOG1Q/lBfoak6hy6YYgW0zb?=
 =?us-ascii?Q?FxIIWW1BEG/DccELP7AbpWIju7fvNQ29zRIu9QuwYRKXJ6BKPiIfdeDfIrPB?=
 =?us-ascii?Q?eFPy2Q0K0ZXzoD02Up7/SiuJWSHjX0ctN1/skvEau1vdFnDAp0LPgGjAQDOm?=
 =?us-ascii?Q?/Nqw8CvQaSr580FcBw1lAxFLum2UOU+uab5e6Gu0hpZw7V3N/+Q3CNm1aRY9?=
 =?us-ascii?Q?0bHjV9bTOlqKlsxByuV6h3ydopfTYj5zwhC2o7F9ErxBKWDfhPAQOEhqW70o?=
 =?us-ascii?Q?Rs/z1isyvlzH0P4LhD4knCJixvx5N0ehx/Z4b7vbDhmKLMKhM4WyAwTELQ+9?=
 =?us-ascii?Q?TQDNexitCXHCqyat+UUkahmXqFr3gBJZbM3FdwJgnmxaWnXW1hiRpAlILLQz?=
 =?us-ascii?Q?ALG2rih40m0Fh89h9dz0iFo5PFGtfjSug4/N1PG6EvKbF5CFbB4Uxw/t+mXD?=
 =?us-ascii?Q?HrbGAgpVYrBV9oVfJgriD5IlFXe2yP23OwnbiZvGk0tOTx2tAQWaPs021ik1?=
 =?us-ascii?Q?msulGJBem7/aJo0uoQMbvBTWA4TBprLUBDoHCG8li8EOYAYQfaXz+JJZ9NlH?=
 =?us-ascii?Q?zoOUTaG7O1B9AFmH92XOvUYv5Y9/MRbeuo905IMqYJYxNmjvX25lm9n2nmJl?=
 =?us-ascii?Q?6CsNUrC0lUmcWo486spTx3eNhc4JGbCE5S6skt7IwF0Vg3VsQxIivm4++BaZ?=
 =?us-ascii?Q?3gcPQIWN9oJJd0I0TJ/wNTdmS2Tp6wkwzgoudUCFGz6F/M+i+MVrkdkEUyiX?=
 =?us-ascii?Q?3gDpuEf35CDJujbkqvFkhwpMbME/XPW2BKWIAVFyxFLYlV4esoOtUB4SiGiI?=
 =?us-ascii?Q?gt5bHLnmI/iWIx2Ym2gSzB6xm8o27ok9cs26rp3/Zxe/f3XKdXU5LMNAdx94?=
 =?us-ascii?Q?AwmuUzjr/WXwZMKTnNynZaPtvHZXvRpuhE0hyuCMCbbdmlXHslrmJ/HtQwNT?=
 =?us-ascii?Q?OsQuA9lGuqX5boZAAIFoyzOm/klVgBURYCnUVZAKXgbeiLfoCsDvSo3WAA/z?=
 =?us-ascii?Q?jwoD0UPxCgat88j2XoExbTrUHYHfQZRyglj+JnlrSfG2/b4RWXJFre47Hf/e?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5DM+O8Sz5HW+h3zgqU0VXU8I4jENHRaoKMoc9WfiDtazRWaiFpOEf8PLSuVgPaPO46cpk36ipTeN5wDr4OT2M8TCBUlG7prwCw2bgCKIcrTX/qyRlODRdZQnbrA/gHrq1icdoGM5uHr42jPKihIK8JUEjstQtSauHjUIIMd5c5ZaEw+XfXruyUFfn2CHsJEWc2tKdf/FhET1aCfhlmk2umtyi3bNezmcp4WK2uOvQrHSPkMG6A4YPKN48PJAkfikk+BGnRnZjvBAl3BvDcWMe08FKuZ85+0u3mXDukdx21/gWUaMlSImwvEqkiOuNExrT4Ov3qN+xlVDZkmumTg4ZTr7cpuuNH11aepH2b5s3TowHJktE/ruGCCtBSO6zt4g/v76Bewl2TOMqaQTtehxK9uJ5t8Z2ts3tFpVj0OIN7hXxTLqkaD9bWR8DwODqMDAYlqZrD5lWaKLY4BXRoRmyjL/5d1jY/XLK5hL95HxS8xwsrueycFeTkGkCVItcHA4gJ/qcEs4bDbsPlDF3/JOQt+PFHdk6RWrrsj8z+x0sNms3mDhvT786qwX8Xgs81r8nDZN45jduCqvr9LuNRp8iD+u5WhvZO7fEB3T+1QiPov+pXlKbN4P82rI+k48d18j+B8eCB+fec76xCcWW+guzEBLj9ttjFoAGFrFZ/pshBgX+5FEoqAc3cQAY0yUJaAku6KpeWKd6IzZsHWbilx+EJxHgfg9Bv8poUdZuT0A5sQXDuhm6/MZBG518YCrUW11dwOIaY2JU/VeyEKwzp47sA851exnVVeubPmcqAlVrjLe1tS4kvAkQOgeWXZXE/RCkcHeffwBni96Hf0eC95ibrb3lQFWQP2BcmEMrgBcM3M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f2176d-e409-4d54-e059-08dafa5b81ea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 20:26:55.6530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8c8iv8gOeCPRGq8kJgIR3wkWbQm38iNFpBotDvgbMyZkncWGyn7InED80x72wubQQWtJ0+NFq7nyfKt/gmS4uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4409
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_13,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=897
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190171
X-Proofpoint-GUID: 1pu1Gvd0RTCoysjPrbr9Ao0DjKaB_EAb
X-Proofpoint-ORIG-GUID: 1pu1Gvd0RTCoysjPrbr9Ao0DjKaB_EAb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

...
> > > > )[   33.566003] INFO: trying to register non-static key.
> > > > )[   33.566400] The code is fine but needs lockdep annotation, or maybe
> > > > )[   33.566813] you didn't initialize this object before use?
> > > > )[   33.567172] turning off the locking correctness validator.
> > > > )[   33.567527] CPU: 0 PID: 7480 Comm: btrfs Not tainted 6.2.0-rc4+ #331
> > > > )[   33.567930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > > > )rel-4
> > > > )[   33.568665] Call Trace:
> > > > )[   33.568830]  <TASK>
> > > > )[   33.568996]  dump_stack_lvl+0x5b/0x73
> > > > )[   33.569256]  register_lock_class+0x48d/0x4a0
> > > > )[   33.569541]  ? __kmem_cache_alloc_node+0x28c/0x340
> > > > )[   33.569854]  ? kmalloc_trace+0x21/0x50
> > > > )[   33.569871]  ? btrfs_lru_cache_store+0x3e/0x1c0
> > > > )[   33.569871]  ? cache_dir_utimes+0xac/0xe0
> > > > )[   33.569871]  ? finish_inode_if_needed+0x14d1/0x17c0
> > > > )[   33.569871]  ? changed_cb+0x1c1/0xbd0
> > > > )[   33.569871]  ? btrfs_ioctl_send+0x1d6e/0x2080
> > > > )[   33.569871]  ? _btrfs_ioctl_send+0xd9/0x120
> > > > )[   33.569871]  __lock_acquire+0x6d/0x1ef0
> > > > )[   33.569871]  lock_acquire+0xd2/0x2e0
> > > > )[   33.569871]  ? mtree_insert_range+0x86/0x170
> > > > )[   33.569871]  ? btrfs_lru_cache_store+0x3e/0x1c0
> > > > )[   33.569871]  _raw_spin_lock+0x2a/0x40
> > > > )[   33.569871]  ? mtree_insert_range+0x86/0x170
> > > > )[   33.569871]  mtree_insert_range+0x86/0x170
> > > > )[   33.569871]  btrfs_lru_cache_store+0x5f/0x1c0
> > > > )[   33.569871]  cache_dir_utimes+0xac/0xe0
> > > > )[   33.569871]  finish_inode_if_needed+0x14d1/0x17c0
> > > > )[   33.569871]  ? lock_is_held_type+0xe3/0x140
> > > > )[   33.569871]  ? find_held_lock+0x2b/0x80
> > > > )[   33.569871]  changed_cb+0x1c1/0xbd0
> > > > )[   33.569871]  ? lock_is_held_type+0xe3/0x140
> > > > )[   33.569871]  ? find_held_lock+0x2b/0x80
> > > > )[   33.569871]  ? lock_release+0x145/0x2f0
> > > > )[   33.569871]  ? read_extent_buffer+0x92/0xb0
> > > > )[   33.569871]  btrfs_ioctl_send+0x1d6e/0x2080
> > > > )[   33.569871]  ? _btrfs_ioctl_send+0xf3/0x120
> > > > )[   33.569871]  ? rcu_read_lock_sched_held+0x36/0x70
> > > > )[   33.569871]  _btrfs_ioctl_send+0xd9/0x120
> > > > )[   33.569871]  ? __lock_acquire+0x397/0x1ef0
> > > > )[   33.569871]  btrfs_ioctl+0x11c1/0x3230
> > > > )[   33.569871]  ? lock_is_held_type+0xe3/0x140
> > > > )[   33.569871]  ? find_held_lock+0x2b/0x80
> > > > )[   33.569871]  ? lock_release+0x145/0x2f0
> > > > )[   33.569871]  __x64_sys_ioctl+0x80/0xb0
> > > > )[   33.569871]  do_syscall_64+0x34/0x80
> > >
> > > Oddly I don't get anything reported here (and lockdep is enabled), but it's
> > > easy to see why it happens.

...
> > > But the spinlock was not initialized, as the whole point of MT_FLAGS_LOCK_EXTERN
> > > is to skip locking (unless I misunderstood its purpose).
> >
> > It appears that there is a misunderstanding here.  The
> > MT_FLAGS_LOCK_EXTERN flag is to specify an external flag, not that you
> > don't care about or won't be locking.
> >
> >

...
> >
> > The mtree_ family of function is part of the simple interface which
> > handles the locking for you.  If you are going to use an external lock,
> > then you should use the advanced interface.. but you have to use a lock.
> >
> > Perhaps the mtree_lock/unlock() pair should be expanded to WARN_ON()
> > MT_FLAGS_LOCK_EXTERN to catch this issue?

The more concerning part is that you were able to call these functions
without an obvious issue on your end.  I suspect that the maple tree
mt->ma_lock was set to something lockdep didn't mind seeing, but was
NULL or, at least, something lockdep did not like for Christoph.

> >
> > Where did you get this idea about how the locking works?  Perhaps a
> > documentation change is also in order.
> 
> Well, I don't remember exactly where I got the idea, but I suppose it
> was from reading maple_tree.h:
> 
> 1) the definition of mt_init_flags() doesn't initialize the spin lock
> if MT_FLAGS_LOCK_EXTERN is set;
> 2) the comment for MT_FLAGS_LOCK_EXTERN says "mt_lock is not used"
> 
> So I guess I inferred that the use of that flag implied the maple tree
> code would not use the spin lock at all.
> 
> Ok, I'll drop the incorrect use of the flag in btrfs then. Thanks.

Thanks.  It's often hard to see such things as the author.  I will look
into how to avoid this from going undetected and update the header
comments.

Regards,
Liam
