Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C676A80FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 12:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCBLZb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 06:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCBLZa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 06:25:30 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CA423DA8
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 03:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677756328; x=1709292328;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wZCs4mYNwNiQUOLh89Kj/+ZBhZMEft9FaAx+YpwGGd0=;
  b=DJiNpvmxlELnZ4Ju6hqdUEGrFH7+A0AwVIXXJG6ueDcLtW5WVHTa/hsK
   +txfilJ7LxBd2m9oEzHgGLdXcetei0zm61xOM0ZsE5GOkRJeOAF1rEeJ6
   r+WU3KqaQdsHzJ6+sbCrQpdyOQw+ME46Sn+l7km01lVsQFwk/4jftjGtQ
   W+oH4aDqX08Sha/u6aDxw7G7pYBhxfLi/NPvXrGkh60ZhEl8YjoEMtlRk
   VCCmAjiSYZMmHQ3H8hLvUij1fvfmZOGFAdBQ26LgS4XZL+mBk9crmxgec
   J2AovEoGUO4C1q/0xTScPozLwV/5DMSuiu4j3KNx0IxrsaRjKlic8Y3qo
   g==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="229586120"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 19:25:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDJ8qHb9Cs/wboPQPhW3UABGhqak9KECt1h8K7v5FvIHkoy7Qv/hs7we+0RmIovkXXHWUlkkZQpjbSpqr4XO5/GkVJfR5Pk0H4gVHWPzzclfEeyXhoB1CmWgQ+a5CxptjJCSTtnopzSic3iWE9XBhcfa9q40AXe4Zal4WwKTAy/YQ2G3FTRGHJilgqT5oEfpUZnDby89b8TOhX8y1mpUMmI966+Q78++LFryJ5AC+MveOEzRUgjKQK4FJL+sBVWhUv4HaY6W+JcYovh3O9fnMXfNezhSBNMEprSRjryGB1NOfmGU2JnEtm/24bHZErltkHkiOxz0IqJAsyN2WnxXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZCs4mYNwNiQUOLh89Kj/+ZBhZMEft9FaAx+YpwGGd0=;
 b=FJecyP0hh7K11KVhguw2h750GrYpOnAsY704laK7ZzWJO3d8V8PL1XzIHdD7EmVE6KkundSiVJv++x3YrTfAvxNxg1/eWwzEsp9IVp+BjJaGN5htXufVI3mz/byY/xVFb9wtcBAjHmcti6/c36tUX4ZIMLR/0kS4BZsQrcWVEMReHAR9itwSR4aKaGKu+YURJ25pBieQ/PyDX78tOy5OjkZg1kMfhK2Fdl14cChJjD+N1BkYEjDaRGw6TW+92UNvsmYEZ8/s5Lv4RRBxhnYOKWh51/w8CSq9yafu+13KjODmKekjMu7opOtJSgQnLA4kgh2dTx9RsVl39SmotzAKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZCs4mYNwNiQUOLh89Kj/+ZBhZMEft9FaAx+YpwGGd0=;
 b=srGy7jJUyZ0G4Izz6TAqJNtgvs1pZVJXi7pR9FY9muH0W0/0TJHwZ7Q7ODOcVM+qNTPrNSpyAheU0yoeJt0cRjYNHzGwNnEoqCC1S+rGoFFJjHbS85kLSqWZVN1mMMQ4gSK2yd3Zulp67E4c5w8lPMwbafzUbCOfDTbvLKirboo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8028.namprd04.prod.outlook.com (2603:10b6:208:347::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 11:25:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 11:25:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZTOvFIu+8wyTHXEOnol2yZkL+G67nUggAgAAHeYA=
Date:   Thu, 2 Mar 2023 11:25:22 +0000
Message-ID: <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
In-Reply-To: <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8028:EE_
x-ms-office365-filtering-correlation-id: 1f5ab7ee-cd60-4499-3b1d-08db1b10cffb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jpJGIo0VQUWZ0sjtBEkr16Ipl59S4d8ik/7rLQb6P1MQdj7Zox66jd4wRZ2fcTiJR0eyX8TeE/g8oLQxVnWVRfHEhXuUX1Gwp4eD4cYzr7FcgzktPvFR+MN3zn3OF5yEJhno6dm+didHfVaTTlUB4ubHYqS81mH/fezHRA8rQIoEbKYN9XKIiUs4zk6PqcqEGlUtJlb4UJJnhecHV/4pqLRQG9xqIXec3+0wn3G7hPYgGACvZuk0xGOnrng1k5BYGApZ0va41P7nXx1yIWfQL/cgzWXtjjubGebjNzM7iXcWOttKk5mYl1brUeo7wzPC8ygo+C3RWkgETdhT98tc9xEY901xkTjBBCOufGXXkIo2qZHvDKyeEHLoHZeTMsJCRFFhr3T+7zPUQPX11NHP0dSK4ODMkdWnhXpaki7EnK3fHq5dfPdC80SH9FCLHmwx1VUBa99g22RvJdlW/KYvn64HwUQpn8NMYTUyr69II5/JKc6XHS5QUBn2vSdX/4ipp11YzDXfJXQyoAcqnNUo54QvWYKp7jHEAZ1vUYK/7NqjCygS/ewhq9BwZtFHSovu7PU0fPfY/EL7UUQ2MmQ/ZZ0UGdNpwhMwdiyHpIETEO51OdUCdYVTvGvioNfvTmUMNE5c5drf7F5MKZa2zjN8W2zGqtCRYdMea/ksg3CYGhuFHyY7IY6C9HkqwKD8J9otsXqcbDONso0cS7b/D5fxc79ojR2Xuvs/yDXGSP/1Dq+tws9V9zxygGG1mcGy4pXzmnrzx1PSccuY5+OcR9yiCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199018)(83380400001)(66899018)(31686004)(36756003)(38100700002)(122000001)(5660300002)(8936002)(82960400001)(31696002)(86362001)(38070700005)(71200400001)(478600001)(186003)(2616005)(6512007)(6486002)(53546011)(6506007)(8676002)(64756008)(66446008)(66476007)(66556008)(2906002)(66946007)(76116006)(41300700001)(316002)(91956017)(4326008)(110136005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUxmeWZjOW44UDlINnpUSzQ5cXdyc2ZKNjBxOHVPdmtVaENHTGJvdGFjcjht?=
 =?utf-8?B?Mm9panhQeWVkalNIOHc1N1UvQUgxakNsbmFjMFgrQ1dZSHZmM084RWUwWm5i?=
 =?utf-8?B?aWE3R3lKQUFiZXltc1g3NnNsZmdCRTBiZUkxdzlxTUF4TVZNTzYvem5lSnpt?=
 =?utf-8?B?OTYwaUxOaHRrcmRhd0NPTS94Qms5Zk4rVmx6VTZMaXg4eWQ1VTFmMWk4L2RL?=
 =?utf-8?B?UGxVTldkWWl1TlBkYmMzVC9QWE1FdnR5aHV4cXFEQlZoSXMrR0s3STZXOGd0?=
 =?utf-8?B?VEU0Sm5nN2VyWFhDbC9MQzFmeVRjT2V1ZTc5c21qN0c3MXdFOVZSYmtCa2pQ?=
 =?utf-8?B?Tm9CZXArd0hkeGJrOVlKOURuYTIzUjd5cDRRKytFRHFRNW1KSUhPU0pIRml1?=
 =?utf-8?B?dnR3T3RHcDNuMkdQUzcrZ1NGcUJoempiS2NXUkFCVEhmSkNZZElrSXJLcUNJ?=
 =?utf-8?B?SDFiNWR6bmpLbEhtUHFUWkpsNEpINnI4dXplQ0Y2dk9aTTFSa0hpZ1dTa3or?=
 =?utf-8?B?VW5RajdyNlNSTjlVREZGRW8yR2srSlIwQkNxVDk4djVNQzUxdm5uRnJvS0VU?=
 =?utf-8?B?elVTUW51RW5xREhoV3ZVdXUrUWFmdUdsSldkTU9xTlpFKzNvSHd6REhmSVBP?=
 =?utf-8?B?UldpM0VnVVgwRVFxcmc4NHRva1piMkZMKytOd290NjMrNGJHNnhXQWlTRWJH?=
 =?utf-8?B?eWpMVjRWZ3hoclVRZ2t4enMwVXpzcGVPZm1OdkxPUUttU3QxOHJjNXRCTXAx?=
 =?utf-8?B?YTlhMWhlby9KVU1pTW9sc1dFUGVuRGsvUkpXeHgrUXF5TkVpSFZ6SE5Yendu?=
 =?utf-8?B?U2JLTlJEbG1FZU5xUnFJSGt2SWlDR1hyalpHWWZhcGQ0Mno5Ymh1NWRPN2Vu?=
 =?utf-8?B?VzNSUW1XZkdxZGJyT2h6TjNTWkVEeEhBYmJzREpwT2hLRUFrU0dhMjhXOHJC?=
 =?utf-8?B?SGp1SG96NkpHOUlkRmwvV0V1L21LeGd4NEJlUWphVC9jVjdKMTNjcmd5R2xN?=
 =?utf-8?B?QTZRVzF2Ulk4Z2hwTldjeXJCNGVRRGRXUEprODRTM3Q2OUhpTk5nR2dJMWZz?=
 =?utf-8?B?eFlzVFJ3bUppS0xad1RGTW1LbTRNSm9FczgxMkRYaXFWcWZhMVYzSDJzZWI3?=
 =?utf-8?B?VGhnb2oyMGpFblFTZXRRcnhkeFMwS2dVcU1xS3VFZVBxR1NUNGlGSHYxYzZy?=
 =?utf-8?B?SW54akF0MERZUWM2Ym9kbDJ0VCt1N3ZCQXhxT1ZaU2Q2VGpvL2JDZlNUcHVF?=
 =?utf-8?B?QUp3YXVMck4zTkhEOUF5Q1p3aERDdEhvYTdzRlVqaUxTU2ZlK2lIeXdqcUxq?=
 =?utf-8?B?ekp2UEs4ODRGTlNGbFU0NlhvYW9IMUFTZlQ5UFdaRXZsa2pMNHJXeWtQNHBM?=
 =?utf-8?B?aUhBT21UWUVTQjY5YVd0TUYrRDc5UW5qeFJlU2JvTTBlbUZHTjJCUUtNVGwy?=
 =?utf-8?B?WG43N1A3UVBrbnVldENpdGRVSXFOUENKUXFKYVh0WEVJNzg2U0gyMkZHRXZI?=
 =?utf-8?B?Y1I3TlIzcDU1NjMrQWt6dlF6R0ErYVhuVVViNGFxQ0lVQVFPNFRvVlcxZFJI?=
 =?utf-8?B?N245WGFuZkJvUUVEK1l6Tk56NnZMUzlPWnQ5K3lDMEsyQkc2TUpIaDFmbkYx?=
 =?utf-8?B?ZWhDS1dHRlBZK1ZOeEJlNTV3UkhZZWVORTg3bVUraXVGWUw0MXJteXFZbEpL?=
 =?utf-8?B?UWNmTndxYjFQdk94TUpXVC9yZmE0M1FJTDB1c0tsOUl2WlcxdC9oNE12VER0?=
 =?utf-8?B?NE1lek1ZK05jN000UzdERW8zZitSeXVTNDlhWFFtNDl2ZW8wWk9wVFE1RXhq?=
 =?utf-8?B?ZFpKT3JRWFJZanlEeDJiRHVzeE1qNnRDSkxnaFljUVNVZHdaQ0QvUDJkL2E0?=
 =?utf-8?B?TytkVDVBdkFjQ0dHaDhiNC9Mam1CbFNlYXBlbTZBTGtTTHFPbHBxODhEejVO?=
 =?utf-8?B?UWdWQXg4c0tYb1dTdm1sYjdCQlNhVEJrMXRsa3V6bmgxSXJzcytSbFNESWhk?=
 =?utf-8?B?RldlNjdKYUdyS2hPTWMwV0dsemtBdXB4dEg4RTA5RW0wYkdVRHhkTnZMdWQw?=
 =?utf-8?B?REo2bFFUNXBoU3dBK2hiVmxKa0ZTcVpRRFFyVDhqYlFOM2xUQk85bE1EVk1G?=
 =?utf-8?B?ZkFGeVRpYTg0eDRDQkZBYWNGVjVJYnltVjhyOFBaUVV1U1ZRK3FkZjk5R3Zm?=
 =?utf-8?B?TWlhRVZpMjNoMVN4ZmVEa1dzYjBXcUJpV24zRE9xRWF1Q1lyOW1IQ3h0bHRV?=
 =?utf-8?B?L0tDUjkvZXN6d3d2bWZFZ2JhcmlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C10C3570816CEC48A65F2FBF6697FA51@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SovQDa4gxtiyaberPtqJo2Nm/lvK0sHM+IvzQn18rMK1+dK+guQjhezuVniuPLBdgwf5ethmyBHTOqhvRWi4EM0VRWWET6GYbE/d2ViEMqL+2Laj5tFqba7sU6JvdcV3UPPhjAZI7gCbj7sr6cNdJh75Zmc4GMmFgX4LXiP+WsfeZ8Mw2lhOxVf98Y0SJqubwMTpVpbQcydbfbvk6ifDhGzgq5wmP0JhIqM5TAC9/AgSVt5IB/npuQdll6pgSmROT23mVxRX5DIrnCWG/43bfJCd+XRIsCFO08H1oaKiNHYbtccQLOCs68yRXk2XJIv7LP/KnYK/9wjEUZ8LA5th1KBME+6UWLUrrwM1kXW0QAdrJCvg1btgcvbR1/kSruNqtVGP4BiY/H3Z+WZrSNXh49MwSyW/UNNBP0824Hr3Er7VhT3Ya5pUXUZgiNthgykGKhvxdKXsx73ASFNvuaLB3bSE4RPEbm/OSdgajJJ+O3pIbhAoRrJUjhAOwjR49OPHI7l+dxFvm9gaU5sM56C5ZFbwpNjXh6vWxIXfEK7zzmkPkEpB3gLtgjV1bWAnpIh4TAUhIhwFI6Auhu34RarJ8EUBxbjG8fgSHfesZaP9NkNHPIVu25aVgEJRV6U7VOaSABCsWvROT9FkOnMs9KQOfxCfVgbMtppaUGG0uAJq4x3dzj3gaVS4qosYxvroqiehRLSWvsTqyFfpToAg7hXvZVwnn1TN18gty/HDwEa0eKzBZT5KbwHNcm8D6vm5xYHkWsrLu450toJPAg7mG9SbYM1yHJip+w9hM0IuS5zZn12N0GOTODVrXdwOVv1gbFx0D8xxhg0nM15YqWNqIxw2zs1E6Up2J96FrpFIU6PgxeGDf1b5Y1GuLlFfOj0FyHgU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5ab7ee-cd60-4499-3b1d-08db1b10cffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 11:25:22.5519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xr1xAW/9cJAA/tNvqkm1C/6waSKHlGz5wJpwA/keZpU1gVbVid3Ev4/hqRHEcmlMlDPWzcVCCVQJWQDDkZkVEeRcAfo0NVwrV3qBUYnMwBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8028
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDIuMDMuMjMgMTE6NTksIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDIzLzMv
MiAxNzo0NSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gQWRkIHN1cHBvcnQgZm9yIGlu
c2VydGluZyBzdHJpcGUgZXh0ZW50cyBpbnRvIHRoZSByYWlkIHN0cmlwZSB0cmVlIG9uDQo+PiBj
b21wbGV0aW9uIG9mIGV2ZXJ5IHdyaXRlIHRoYXQgbmVlZHMgYW4gZXh0cmEgbG9naWNhbC10by1w
aHlzaWNhbA0KPj4gdHJhbnNsYXRpb24gd2hlbiB1c2luZyBSQUlELg0KPj4NCj4+IEluc2VydGlu
ZyB0aGUgc3RyaXBlIGV4dGVudHMgaGFwcGVucyBhZnRlciB0aGUgZGF0YSBJL08gaGFzIGNvbXBs
ZXRlZCwNCj4+IHRoaXMgaXMgZG9uZSB0byBhKSBzdXBwb3J0IHpvbmUtYXBwZW5kIGFuZCBiKSBy
dWxlIG91dCB0aGUgcG9zc2liaWxpdHkgb2YNCj4+IGEgUkFJRC13cml0ZS1ob2xlLg0KPj4NCj4+
IFRoaXMgaXMgZG9uZSBieSBjcmVhdGluZyBpbi1tZW1vcnkgb3JkZXJlZCBzdHJpcGUgZXh0ZW50
cywganVzdCBsaWtlIHRoZQ0KPj4gaW4gbWVtb3J5IG9yZGVyZWQgZXh0ZW50cywgb24gSS9PIGNv
bXBsZXRpb24gYW5kIHRoZSBvbi1kaXNrIHJhaWQgc3RyaXBlDQo+PiBleHRlbnRzIGdldCBjcmVh
dGVkIG9uY2Ugd2UncmUgcnVubmluZyB0aGUgZGVsYXllZF9yZWZzIGZvciB0aGUgZXh0ZW50DQo+
PiBpdGVtIHRoaXMgc3RyaXBlIGV4dGVudCBpcyB0aWVkIHRvLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+PiAt
LS0NCj4+ICAgZnMvYnRyZnMvTWFrZWZpbGUgICAgICAgICAgIHwgICAyICstDQo+PiAgIGZzL2J0
cmZzL2Jpby5jICAgICAgICAgICAgICB8ICAyOSArKysrKw0KPj4gICBmcy9idHJmcy9kZWxheWVk
LXJlZi5jICAgICAgfCAgIDYgKy0NCj4+ICAgZnMvYnRyZnMvZGVsYXllZC1yZWYuaCAgICAgIHwg
ICAyICsNCj4+ICAgZnMvYnRyZnMvZXh0ZW50LXRyZWUuYyAgICAgIHwgIDYwICsrKysrKysrKysr
DQo+PiAgIGZzL2J0cmZzL2lub2RlLmMgICAgICAgICAgICB8ICAxNSArKy0NCj4+ICAgZnMvYnRy
ZnMvcmFpZC1zdHJpcGUtdHJlZS5jIHwgMjA0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPj4gICBmcy9idHJmcy9yYWlkLXN0cmlwZS10cmVlLmggfCAgNzEgKysrKysrKysr
KysrKw0KPj4gICBmcy9idHJmcy92b2x1bWVzLmMgICAgICAgICAgfCAgIDQgKy0NCj4+ICAgZnMv
YnRyZnMvdm9sdW1lcy5oICAgICAgICAgIHwgIDEzICstLQ0KPj4gICBmcy9idHJmcy96b25lZC5j
ICAgICAgICAgICAgfCAgIDMgKw0KPj4gICAxMSBmaWxlcyBjaGFuZ2VkLCAzOTcgaW5zZXJ0aW9u
cygrKSwgMTIgZGVsZXRpb25zKC0pDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBmcy9idHJmcy9y
YWlkLXN0cmlwZS10cmVlLmMNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGZzL2J0cmZzL3JhaWQt
c3RyaXBlLXRyZWUuaA0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9NYWtlZmlsZSBiL2Zz
L2J0cmZzL01ha2VmaWxlDQo+PiBpbmRleCA5MGQ1MzIwOTc1NWIuLjNiYjg2OWE4NGU1NCAxMDA2
NDQNCj4+IC0tLSBhL2ZzL2J0cmZzL01ha2VmaWxlDQo+PiArKysgYi9mcy9idHJmcy9NYWtlZmls
ZQ0KPj4gQEAgLTMzLDcgKzMzLDcgQEAgYnRyZnMteSArPSBzdXBlci5vIGN0cmVlLm8gZXh0ZW50
LXRyZWUubyBwcmludC10cmVlLm8gcm9vdC10cmVlLm8gZGlyLWl0ZW0ubyBcDQo+PiAgIAkgICB1
dWlkLXRyZWUubyBwcm9wcy5vIGZyZWUtc3BhY2UtdHJlZS5vIHRyZWUtY2hlY2tlci5vIHNwYWNl
LWluZm8ubyBcDQo+PiAgIAkgICBibG9jay1yc3YubyBkZWxhbGxvYy1zcGFjZS5vIGJsb2NrLWdy
b3VwLm8gZGlzY2FyZC5vIHJlZmxpbmsubyBcDQo+PiAgIAkgICBzdWJwYWdlLm8gdHJlZS1tb2Qt
bG9nLm8gZXh0ZW50LWlvLXRyZWUubyBmcy5vIG1lc3NhZ2VzLm8gYmlvLm8gXA0KPj4gLQkgICBs
cnVfY2FjaGUubw0KPj4gKwkgICBscnVfY2FjaGUubyByYWlkLXN0cmlwZS10cmVlLm8NCj4+ICAg
DQo+PiAgIGJ0cmZzLSQoQ09ORklHX0JUUkZTX0ZTX1BPU0lYX0FDTCkgKz0gYWNsLm8NCj4+ICAg
YnRyZnMtJChDT05GSUdfQlRSRlNfRlNfQ0hFQ0tfSU5URUdSSVRZKSArPSBjaGVjay1pbnRlZ3Jp
dHkubw0KPj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2Jpby5jIGIvZnMvYnRyZnMvYmlvLmMNCj4+
IGluZGV4IDcyNjU5Mjg2OGU5Yy4uMmIxNzQ4NjVkMzQ3IDEwMDY0NA0KPj4gLS0tIGEvZnMvYnRy
ZnMvYmlvLmMNCj4+ICsrKyBiL2ZzL2J0cmZzL2Jpby5jDQo+PiBAQCAtMTUsNiArMTUsNyBAQA0K
Pj4gICAjaW5jbHVkZSAicmN1LXN0cmluZy5oIg0KPj4gICAjaW5jbHVkZSAiem9uZWQuaCINCj4+
ICAgI2luY2x1ZGUgImZpbGUtaXRlbS5oIg0KPj4gKyNpbmNsdWRlICJyYWlkLXN0cmlwZS10cmVl
LmgiDQo+PiAgIA0KPj4gICBzdGF0aWMgc3RydWN0IGJpb19zZXQgYnRyZnNfYmlvc2V0Ow0KPj4g
ICBzdGF0aWMgc3RydWN0IGJpb19zZXQgYnRyZnNfY2xvbmVfYmlvc2V0Ow0KPj4gQEAgLTM0OCw2
ICszNDksMjEgQEAgc3RhdGljIHZvaWQgYnRyZnNfcmFpZDU2X2VuZF9pbyhzdHJ1Y3QgYmlvICpi
aW8pDQo+PiAgIAlidHJmc19wdXRfYmlvYyhiaW9jKTsNCj4+ICAgfQ0KPj4gICANCj4+ICtzdGF0
aWMgdm9pZCBidHJmc19yYWlkX3N0cmlwZV91cGRhdGUoc3RydWN0IHdvcmtfc3RydWN0ICp3b3Jr
KQ0KPj4gK3sNCj4+ICsJc3RydWN0IGJ0cmZzX2JpbyAqYmJpbyA9DQo+PiArCQljb250YWluZXJf
b2Yod29yaywgc3RydWN0IGJ0cmZzX2JpbywgZW5kX2lvX3dvcmspOw0KPj4gKwlzdHJ1Y3QgYnRy
ZnNfaW9fc3RyaXBlICpzdHJpcGUgPSBiYmlvLT5iaW8uYmlfcHJpdmF0ZTsNCj4+ICsJc3RydWN0
IGJ0cmZzX2lvX2NvbnRleHQgKmJpb2MgPSBzdHJpcGUtPmJpb2M7DQo+PiArCWludCByZXQ7DQo+
PiArDQo+PiArCXJldCA9IGJ0cmZzX2FkZF9vcmRlcmVkX3N0cmlwZShiaW9jKTsNCj4+ICsJaWYg
KHJldCkNCj4+ICsJCWJiaW8tPmJpby5iaV9zdGF0dXMgPSBlcnJub190b19ibGtfc3RhdHVzKHJl
dCk7DQo+PiArCWJ0cmZzX29yaWdfYmJpb19lbmRfaW8oYmJpbyk7DQo+PiArCWJ0cmZzX3B1dF9i
aW9jKGJpb2MpOw0KPj4gK30NCj4+ICsNCj4+ICAgc3RhdGljIHZvaWQgYnRyZnNfb3JpZ193cml0
ZV9lbmRfaW8oc3RydWN0IGJpbyAqYmlvKQ0KPj4gICB7DQo+PiAgIAlzdHJ1Y3QgYnRyZnNfaW9f
c3RyaXBlICpzdHJpcGUgPSBiaW8tPmJpX3ByaXZhdGU7DQo+PiBAQCAtMzcwLDYgKzM4NiwxNiBA
QCBzdGF0aWMgdm9pZCBidHJmc19vcmlnX3dyaXRlX2VuZF9pbyhzdHJ1Y3QgYmlvICpiaW8pDQo+
PiAgIAllbHNlDQo+PiAgIAkJYmlvLT5iaV9zdGF0dXMgPSBCTEtfU1RTX09LOw0KPj4gICANCj4+
ICsJaWYgKGJpb19vcChiaW8pID09IFJFUV9PUF9aT05FX0FQUEVORCkNCj4+ICsJCXN0cmlwZS0+
cGh5c2ljYWwgPSBiaW8tPmJpX2l0ZXIuYmlfc2VjdG9yIDw8IFNFQ1RPUl9TSElGVDsNCj4+ICsN
Cj4+ICsJaWYgKGJ0cmZzX25lZWRfc3RyaXBlX3RyZWVfdXBkYXRlKGJpb2MtPmZzX2luZm8sIGJp
b2MtPm1hcF90eXBlKSkgew0KPj4gKwkJSU5JVF9XT1JLKCZiYmlvLT5lbmRfaW9fd29yaywgYnRy
ZnNfcmFpZF9zdHJpcGVfdXBkYXRlKTsNCj4+ICsJCXF1ZXVlX3dvcmsoYnRyZnNfZW5kX2lvX3dx
KGJpb2MtPmZzX2luZm8sIGJpbyksDQo+PiArCQkJJmJiaW8tPmVuZF9pb193b3JrKTsNCj4gDQo+
IEknbSBzdGlsbCBoYXZpbmcgdGhlIG9sZCBxdWVzdGlvbiwgd2hhdCB3b3VsZCBoYXBwZW4gaWYg
dGhlIGRlbGF5ZWQgDQo+IHdvcmtsb2FkIGhhcHBlbiBhZnRlciB0aGUgb3JkZXJlZCBleHRlbnQg
ZmluaXNoZWQ/DQo+IA0KPiBTaW5jZSB3ZSBjYW4gbm90IGVuc3VyZSB0aGUgb3JkZXIgYmV0d2Vl
biB0aGlzIFJTVCB1cGRhdGUgd29ya2xvYWQgYW5kIA0KPiBmaW5pc2hfb3JkZXJlZF9pbygpLCB0
aGVyZSBjYW4gYmUgYW4gd2luZG93IHdoZXJlIHdlIGZpbmlzaCBvcmRlcmVkIGlvLCANCj4gYW5k
IHRoZW4gdGhlIHBhZ2VzIGdldCByZWxlYXNlZCAoYnkgbWVtb3J5IHByZXNzdXJlKSwgdGhlbiBh
IG5ldyByZWFkIA0KPiBoYXBwZW4gdG8gdGhlIHJhbmdlLCB0aGVuIG91ciBSU1Qgd29ya2xvYWQg
aGFwcGVuZWQuDQo+IA0KPiBJbiB0aGF0IGNhc2UsIHdlIHdvdWxkIGhhdmUgcmVhZCBmYWlsdXJl
Lg0KPiANCj4gDQo+IFRodXMgSSBzdHJvbmdseSByZWNvbW1lbmVkIHRvIGRvIHRoZSBSU1QgdHJl
ZSB1cGRhdGUgaW5zaWRlIA0KPiBmaW5pc2hfb3JkZXJlZF9pbygpLg0KPiANCj4gVGhpcyBoYXMg
c2V2ZXJhbCBhZHZhbnRhZ2VzOg0KPiANCj4gLSBXZSBkb24ndCBuZWVkIGluLW1lbW9yeSBzdHJ1
Y3R1cmUgYXMgYSBnYXAgc3RvcHBlcg0KPiAgICBTaW5jZSByZWFkIHdvdWxkIGJlIGJsb2NrZWQg
aWYgdGhlcmUgaXMgYSBydW5uaW5nIG9yZGVyZWQgZXh0ZW50LA0KPiAgICB3ZSBkb24ndCBuZWVk
IGFuIGluLW1lbW9yeSBSU1QgbWFwcGluZy4NCj4gDQo+IC0gZmluaXNoX29yZGVyZWRfaW8oKSBp
dHNlbGYgaGFzIGFsbCB0aGUgcHJvcGVyIGNvbnRleHQgZm9yIHRyZWUNCj4gICAgdXBkYXRlcy4N
Cj4gICAgQXMgdGhhdCdzIHRoZSBtYWluIGxvY2F0aW9uIHdlIHVwZGF0ZSB0aGUgc3Vidm9sdW1l
IHRyZWUuDQoNClRoZSBmaXJzdCB2ZXJzaW9ucyBvZiB0aGlzIHBhdGNoc2V0IGRpZCBkbyB0aGF0
IGFuZCB0aGVuIHlvdSBhc2tlZCBtZQ0KdG8gY3JlYXRlIGFuIGluLW1lbW9yeSBzdHJ1Y3R1cmUg
YW5kIGRvIHRoZSB1cGRhdGUgYXQgZGVsYXllZCByZWYgdGltZS4NCg0KSG93IGFib3V0IGFkZGlu
ZyBhIGNvbXBsZXRpb24sIG9yIHNvbWV0aGluZyBsaWtlIGEgYXRvbWljX3QgDQpvcmRlcmVkX3N0
cmlwZXNfcGVuZGluZyBmb3IgdGhlIFJTVCB1cGRhdGVzIGFuZCBoYXZlIA0KZmluaXNoX29yZGVy
ZWRfaW8oKSB3YWl0aW5nIGZvciBpdD8NCg0KPiBUaGUgbWFpbiBjb25jZXJuIG1heSBiZSB0aGUg
YmlvYyA8LT4gb3JkZXJlZCBleHRlbnQgbWFwcGluZywgYnV0IElJUkMgDQo+IGZvciB6b25lZCBt
b2RlIG9uZSBiaW9jIGlzIG9uZSBvcmRlcmVkIGV4dGVudCwgdGh1cyB0aGlzIHNob3VsZG4ndCBi
ZSBhIA0KPiBzdXBlciBiaWcgZGVhbD8NCg0KWWVwLCBidXQgSSB3YW50IHRvIGJlIGFibGUgdG8g
dXNlIFJTVCBmb3Igbm9uLXpvbmVkIGRldmljZXMgYXMgd2VsbA0KdG8gYXR0YWNrIHRoZSBSQUlE
NTYgcHJvYmxlbXMgYW5kIGFkZCBlcmFzdXJlIGNvZGluZyBSQUlELg0KDQo+IE90aGVyd2lzZSB3
ZSBtYXkgbmVlZCBzb21ldGhpbmcgdG8gdHJhY2UgYWxsIHRoZSBiaW9jIGJlbG9uZyB0byB0aGUg
DQo+IG9yZGVyZWQgZXh0ZW50Lg0KDQo=
