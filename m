Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42CD51B236
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 00:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351127AbiEDWr7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 18:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbiEDWr6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 18:47:58 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBD653711
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1651704259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/hDxac7kmnvSobJkGvDPhUcB48taDqD730joaB61I4=;
        b=SxaxU1veKElFQAJAsdrEECK88tsRzs9UvqWf9P0+8bnUV0qVSyaGtHJH3wCshdKlT0glIa
        GJN4vLDea1oMh8343MBj2AuNJspA7YGBrxtE4Uy/EAoVh9M4MWPrCxaOuznQRyl2EAslfW
        tkPxLc6lxnU/ya4Kc7hxEY+QW5KRles=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-GQ7_Lq6kOje60WMgvOnghA-1; Thu, 05 May 2022 00:44:15 +0200
X-MC-Unique: GQ7_Lq6kOje60WMgvOnghA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbNyd3pDAirk6gY3d8j4EJ//j7C6rPLRgeGUjTicqH4MSuZ/N5wMDP0mmoKFGN0lL3YqwrZaWt8vsf2yKSXaSaUewTqYf2a0QR6RALCLrkD3eSVVKW/8TlYXmjF8Qxz2HB+FxrRn9cxgCYS9+6LVM3iuEXRJ+6x1ETpGlU5HqaXUdQ1YAWECXDUJSOVwqfk3TEB1G19rUWlza3nzUsdlhaXx2UccLIr3kk647CrQmjm08n+Lss9RtpcB8wSyv4ZORoDhSmtzJcUxpB2e4W8FYS9ECH6cjq8BvuzAAWEm7MwBSWc7HbsydlB2QCfN+l/tnqDxXdNqknPX7U7a9ZQW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JVV13eAaXvefPZaxEou94ikH+US42CgnWdlJVmFNaQ=;
 b=kBssYHOXVMnSDu94ULr8vECUAAR26iSnoK3oZUqDqybAeRWBFv94GT41ow/cLWNRebJwFu+PAu5B37lV1752Mh93fLVNF1Uc+5gg/velnkhYk5By26tdnPo0nnZM5KTaM4nKrcxdyyUG3HlXFQrsBFIB1MVGILBBLZTImlLxgLt8XI1trY6UxG163hTWqyZP9HjNCgarfIHBLIrou+bD/ccZjEfdgHTIHJ7TRsvXNsV+2wXApjp/fIptzip4uznL860yJQN8EVhcz9pbCD5F1MEUBupCnlFak+bQ3ueqXGSJpGefRuDRqUbQOymcTmjqcSYC/L0Bf3unQJOkqYCJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VI1PR0401MB2350.eurprd04.prod.outlook.com (2603:10a6:800:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Wed, 4 May
 2022 22:44:11 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::917f:6f1:b888:b74f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::917f:6f1:b888:b74f%8]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 22:44:11 +0000
Message-ID: <c026bdcc-3e06-cf85-b1af-bcc617be7ff9@suse.com>
Date:   Thu, 5 May 2022 06:44:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 04/10] btrfs: split btrfs_submit_data_bio
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Christoph Hellwig <hch@lst.de>
CC:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20220504122524.558088-1-hch@lst.de>
 <20220504122524.558088-5-hch@lst.de>
 <4b4e9991-3c1b-6758-3e1d-c6aafac61c13@gmx.com>
 <20220504140851.GA17969@lst.de>
 <b9283134-54b4-5a9a-f8c4-099cdb5df6fb@gmx.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <b9283134-54b4-5a9a-f8c4-099cdb5df6fb@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:332::27) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02888f38-6fe6-4d08-62ee-08da2e1f9b1f
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2350:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23504B61AFC6F733A157C49AD6C39@VI1PR0401MB2350.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fL+V8cRc721/0/cgN6upritRBom9LBl3yylVIi1HEXmel6HncR5hSpPHc6DF9r0Mgi1vJUKEsn8FECHCFCWAiv6TiKqUtIA/4hYAz/7Z/m200NQNDuy6RxIktsnkj2Gr3ZK8GZQE/8OHGbzDeTzBMqWLTYVO+W15j9CZwzE5kMYZWDCaMR3o0OKPwkTisHYYKJvXiDjPQ+ptATdMR4VIEPkvMGO6I/YsYfP6foQPI33/YQcaUhlfnm+TUSzR51ABkTFAuEKpwFBW7FHQiUrk10YB2E3qmqMHv9CYsJ6/NmAAAnwM8Dr7rKO9AEVOm6QKqHQZn+lWWuv1XXA+n6BX4xnOqGC7KV4k5ayyL/lzgHcGMI4LPmGhxlvixsmse73hMRuAzIQ6dFD56M2+KqFnVbEheQUMlRmZAxchLZZfuGkO4WNUNPKUCJTql/Maii7v5QeRV2p6H+IDNwlbCgZnTF7H/OqYqGxVfqtRhG5P3gVLcvGe1wx2AJlITXJZDO7SNKTYjnoSiMwY0uHUdI7cCcDoqo/OFCSYppFi2/HbrzsM1xiRatRpWPpw0IFzT8nTGE5rfKXhZRdoykP+D+jr9NkovAKNLqz9lIM1pj8mOFYVaDwAoDPFkBuAzQtDHpqmJPkuR+q9oiF30dIBZF4+fVCAO/vBC66QdASsrM5hBJxpiZPmWxzYk6PV5XsR5JI+W4RW7zVtq4Mfjh9168IiedE3xpin22s3eRnMfOYbvOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(66476007)(8936002)(508600001)(66556008)(316002)(66946007)(110136005)(86362001)(54906003)(31696002)(38100700002)(4326008)(26005)(6512007)(2906002)(5660300002)(31686004)(6506007)(53546011)(186003)(2616005)(36756003)(6666004)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JEEECwhUojyrv+hbprqyvx3fqnYyddxTpBez16DeahZJugcyP2GOpDPYTkLu?=
 =?us-ascii?Q?nfKhK3maDC6/fecHqZmzve1MVq3R+2OiHOJwZy0YADeupg6EEaxYAKXWeN3+?=
 =?us-ascii?Q?qA81ELlOhFXmS+NjDkVlSuOvLwSi/dJcvRn8j/jLPP9aXbySMBnoaFDfWUwT?=
 =?us-ascii?Q?fl/jfNmqN64e4dVTQcBUxL5CeOMvzg5At+YYoPHj7CMWHR+qPQEbIx9cvyHe?=
 =?us-ascii?Q?3jBBJ706BVRpUZf/gi5yt+GozbAaOQbxov8YbAHTia9a8VbOeM9jp9FcCsXK?=
 =?us-ascii?Q?xNV3BenTlhZNVXJknXfHYQtps2RuWWb8U+PSjeU2HercoGM0B6l3cJI+4Haz?=
 =?us-ascii?Q?13LNjH/z0hzJHpUPkYgFN7zbif5vg/3Z811J+eVUnVo0AzUoXMSHsnW/un4l?=
 =?us-ascii?Q?UryFH5wUbxz3oFBkHYUaHV2kqE5vdxGBxyHS6M+PiBJnXkksutpWD+H08P4l?=
 =?us-ascii?Q?K4kmtCUJx+wUmpHYMBZkowhcZyHUk0xtyKcesJoZit1SNXMeCrrvr73en6bq?=
 =?us-ascii?Q?tsMK6JN3ejIIMmv59vVeZ5yWG5rmnmiwrY0j9vmxClMa+aKUQoJI0v6UR+Ta?=
 =?us-ascii?Q?6H/dv225GQ8QuZyMlZ9GRfsmXiZnK/beLh3lyAqDh3pbC9K9UF+07PvtUo34?=
 =?us-ascii?Q?JMuS0AJyiNRQYGm/t/a5Hv1vCg3bHF01WLjOw1L854mQPyxAKD44R7ozE0VG?=
 =?us-ascii?Q?P4DsTasY1ecRf6fVyFLNefjYrbHA3xK2CHx8bTQaER1aIEC5SGFzOxr/R9Dl?=
 =?us-ascii?Q?5/A0OYBlsAMefl5VDzs0eFk8vkWtAipz55BIeKvM5QL3D1+qFFxrEgLs8UEQ?=
 =?us-ascii?Q?psaFT/UA6Tvp1djxI8gLVK3LbXXwv4cxPBI3c5guZPjyJYLs1oSgk/R8s4kr?=
 =?us-ascii?Q?Ylx9V/Gt2cr2EGPbHGRlQExWHBB0vJPgNQsAP4p47E49jj8G9Z1w8lFITo+x?=
 =?us-ascii?Q?DPkjeZhUtYO+5M2RNRLfOWCBS95GchPp6kq6VK6z4MJU3uM9J8a1/LVnx5c9?=
 =?us-ascii?Q?gls6aZLP026nkhhM50WtCm3ESrNgv2U1kV/vA+WJg9tOjKbvsMhlQQdth6Kl?=
 =?us-ascii?Q?BrWs4axh4Fvh+TJJfXqmaqWJHlwRjgJ/7aBju6QHrkMJY+g9Cni2R+UtMn9n?=
 =?us-ascii?Q?kpk4JzN026pMo31/sS2rnGSjDW9UXRj6xJAU+05heKojhIDQsLlR7AXt59KY?=
 =?us-ascii?Q?TLUdjSX4DZS0LygRJXgWqeoCxVmSJTZy5vwdbE6nccj8YJJ4pxCf/ZBwysVT?=
 =?us-ascii?Q?0klOosv54ni5Dn65r//rVZfbPv7PbDfCiXI28p3L8diFxdlBayyRlfV5YjF3?=
 =?us-ascii?Q?yDnRxl8s0HjIfi9m1aJpEAisl/DZ9xJeJEditf1ZYGWVcZnF0awD3/dYESm0?=
 =?us-ascii?Q?UcCHPO6kfMydE1y4H+lPoe6fULm2AQgvuN+MKjSjE4VuIY5WqbQ3spkzVLwT?=
 =?us-ascii?Q?0EScM8rfgDrJbCiCLh5kXz5brfJMDn3BTB48pFagCEzsVMUW56oqjY8KWuEK?=
 =?us-ascii?Q?O0Yz4nacbL23yXFybx/vjHYnq5ea/DZko0HXNiFruBY9hidQLgVYxOSZ8uCm?=
 =?us-ascii?Q?8NAUHr2HXkMY/iGjSrUi6jOqRvbeROuxynu2c3CNNDhmOM9AkhhvDnf/Dx3i?=
 =?us-ascii?Q?yHZQsOA80KgkUJdHZ9X4PSOKn1hDOwbaDNuBAZbUoqO5X71cePKL01gS6poR?=
 =?us-ascii?Q?820v7+LZUfPKlvOO8Mtq0cIGxVjY+h0IudeT/bT7iVZa05A7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02888f38-6fe6-4d08-62ee-08da2e1f9b1f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 22:44:11.2766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4C9cnE6OeN8xIRDl16nMTnWka/5SAaFkxsfqaJgC2DLJxADyH6CD0vGd+qOtaMBV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2350
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/5 06:41, Qu Wenruo wrote:
>=20
>=20
> On 2022/5/4 22:08, Christoph Hellwig wrote:
>> On Wed, May 04, 2022 at 08:38:23PM +0800, Qu Wenruo wrote:
>>>> +=C2=A0=C2=A0=C2=A0 struct inode *inode =3D tree->private_data;
>>>
>>> I guess we shouldn't use the extent_io_tree for bio->bi_private at all
>>> if we're just tring to grab an inode.
>>>
>>> In fact, for all submit_one_bio() callers, we are handling buffered
>>> read/write, thus we can grab inode using
>>> bio_first_page_all(bio)->mapping->host.
>>>
>>> No need for such weird io_tree based dance.
>>
>> Yes, we can eventully.=C2=A0 Not for this series, though.
>=20
> Looking forward to the new cleanups on various weird private member usage=
.
>>
>>>> -=C2=A0=C2=A0=C2=A0 if (is_data_inode(tree->private_data))
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_submit_data_bio(tree=
->private_data, bio, mirror_num,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compr=
ess_type);
>>>> +=C2=A0=C2=A0=C2=A0 if (!is_data_inode(tree->private_data))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_submit_metadata_bio(=
inode, bio, mirror_num);
>>>
>>> Can we just call btrfs_submit_metadata_bio() and return?
>>>
>>> Every time I see an "if () else if ()", I can't stop thinking if we hav=
e
>>> some corner cases not taken into consideration.
>>
>> I generally agree with you, but for this case I think it is pretty
>> simple.=C2=A0 But a few more series down the road these helpers will cha=
nge
>> a bit anyway, so we can revisit it.
>>
> OK, that sounds good.
>=20
> Just a little worried about how many series there still are...
>=20
> Thanks,
> Qu
>=20

Oh, forgot the tag.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

