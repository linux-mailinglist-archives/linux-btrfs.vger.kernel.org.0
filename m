Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17C8380BFC
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 16:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhENOju (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 10:39:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232520AbhENOjt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 10:39:49 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14EEY5Gw094246;
        Fri, 14 May 2021 10:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=/ylH10U0WQkTGEe9NLcxbI6GRXp/+0hINXRx9z8ZYJQ=;
 b=oRK5re/hkgupgG/EDmyFGxueM0RvMgPhQJPlkqXa6TxYbKBDAsXRyLHggZ1T2lmWZp2m
 MnF0u+6BqAPO5gm3YTCr09PVwJVVEot//8ql2mhlBMPCcRtDZQXfOekgWLzui78+/07D
 OxT2MfnLiuzKaD/MwTCsDQurKld7ONCOGXpmlwj2PjEbqGW0m0JlshIzvyurtuFFPrtp
 jNic7KHGXOtT6eQtcOjwqLbu4avH8+s3t0+11ZCH2UY0lwhiecZjsle0Yh6fsVCezPsK
 Trvd+4O5FWcrCOctjSxKWinXgHQeRwIf5gYErpWV7QW5YlLmayn8ypY/Dq6B93h6Vvrh lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38hrrbuu86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 10:38:32 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14EEZ5Lx101292;
        Fri, 14 May 2021 10:38:32 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38hrrbuu7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 10:38:32 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14EEXw79024566;
        Fri, 14 May 2021 14:38:30 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 38hc6pgb6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 14:38:30 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14EEc0Ir33685898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 14:38:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C79F44205E;
        Fri, 14 May 2021 14:38:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74B384204D;
        Fri, 14 May 2021 14:38:27 +0000 (GMT)
Received: from localhost (unknown [9.77.196.130])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 May 2021 14:38:27 +0000 (GMT)
Date:   Fri, 14 May 2021 20:08:26 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 00/42] btrfs: add data write support for subpage
Message-ID: <20210514143826.4g6kj23kymzijpgr@riteshh-domain>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210512221821.GB7604@twin.jikos.cz>
 <de2c2a25-a8da-4d69-819e-847c4721b3f4@gmx.com>
 <36e94393-d6cf-cc3d-d710-79c517de4ecc@gmx.com>
 <20210513225409.GL7604@twin.jikos.cz>
 <2b05bb47-f16c-62dd-d234-8bffdd332081@gmx.com>
 <20210514022609.lixjorvhu6mwsaoe@riteshh-domain>
 <20210514102840.kifj3ryzrw5utwj4@riteshh-domain>
 <20210514112825.GU7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514112825.GU7604@twin.jikos.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rlxmHy0Kagy_3qxQ5dvR0Yz3AGMwYtSt
X-Proofpoint-ORIG-GUID: 9eJFEoRvhcfaOGxUZpP_RVhVmpyhBngn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_06:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140118
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/14 01:28PM, David Sterba wrote:
> On Fri, May 14, 2021 at 03:58:40PM +0530, riteshh wrote:
> > On 21/05/14 07:56AM, riteshh wrote:
> > > On 21/05/14 09:41AM, Qu Wenruo wrote:
> > > If it helps, I tested "-g quick" on PPC64 with 64k config for 1-13 patches of
> > > this patch series and didn't find any regression/crash with xfstests.
> > > I am running "-g auto" now, will let you know the results once it completes.
> >
> > I tested these patches (1-13) with "-g auto" config and I didn't see any
> > regression/crashes on PPC64 platform.
>
> Yes it helps, thanks for testing. You could also let the fstests run in
> a loop or with different memory/cpu setup, this can catch some races.

Oh yes, sure. Earlier I wanted to complete one round of testing of this auto
test, as auto tests take some good time to complete.
Later I can keep your suggested method to tests in a loop for this full patch
series from Qu.

Thanks
ritesh
